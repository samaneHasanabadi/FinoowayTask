package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.config.FileStorageProperties;
import ir.samane.homeservicesoft.exceptions.FileStorageException;
import ir.samane.homeservicesoft.exceptions.ImageWrongFormatException;
import ir.samane.homeservicesoft.model.entity.Expert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class FileStorageService {
    private final Path fileStorageLocation;
    @Autowired
    private ExpertService expertService;

    @Autowired
    public FileStorageService(FileStorageProperties fileStorageProperties) {
        this.fileStorageLocation = Paths.get(fileStorageProperties.getUploadDir())
                .toAbsolutePath().normalize();
        try {
            Files.createDirectories(this.fileStorageLocation);
        } catch (Exception ex) {
            throw new FileStorageException("Could not create the directory where the uploaded files will be stored.", ex);
        }
    }

    public String storeFile(MultipartFile file, int id) throws Exception{
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        try {
            if(fileName.contains("..")) {
                throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fileName);
            }
            String[] parts = fileName.split("\\.");
            if(!parts[1].equals("jpg"))
                throw new ImageWrongFormatException("Format of image must be \"jpg\"");
            fileName = id + fileName;
            Expert expert = saveImage(id, fileName);
            copyImage(file, fileName);
            return expert.getName();
        } catch (IOException ex) {
            throw new FileStorageException("Could not store file " + fileName + ". Please try again!", ex);
        }
    }

    private void copyImage(MultipartFile file, String fileName) throws IOException {
        Path targetLocation = this.fileStorageLocation.resolve(fileName);
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
    }

    private Expert saveImage(int id, String fileName) throws Exception {
        Expert expert = expertService.findById(id);
        expert.setImage(fileName);
        expertService.saveExpert(expert);
        return expert;
    }
}
