package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.config.FileStorageProperties;
import ir.samane.homeservicesoft.exceptions.FileStorageException;
import ir.samane.homeservicesoft.exceptions.ImageWrongFormatException;
import ir.samane.homeservicesoft.model.entity.Expert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
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
     private long maxFileSize = 300000;

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

    public void storeFile(MultipartFile file, int id) throws Exception{
        checkFileSize(file);
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        try {
            if(fileName.contains("..")) {
                throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fileName);
            }
            String[] parts = fileName.split("\\.");
            if(!parts[1].equals("jpg"))
                throw new ImageWrongFormatException("Format of image must be \"jpg\"");
            fileName ="" + id ;
            copyImage(file, fileName);
        } catch (IOException ex) {
            throw new FileStorageException("Could not store file " + fileName + ". Please try again!", ex);
        }
    }

    private void checkFileSize(MultipartFile file) throws Exception {
        if (file.getSize() > maxFileSize){
            throw new Exception("image size exceeds 300kb!");
        }
    }

    private void copyImage(MultipartFile file, String fileName) throws IOException {
        Path targetLocation = this.fileStorageLocation.resolve(fileName);
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
    }

}
