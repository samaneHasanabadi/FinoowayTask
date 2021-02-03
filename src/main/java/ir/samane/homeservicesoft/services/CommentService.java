package ir.samane.homeservicesoft.services;

import ir.samane.homeservicesoft.model.dao.CommentDao;
import ir.samane.homeservicesoft.model.entity.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {

    private CommentDao commentDao;

    @Autowired
    public void setCommentDao(CommentDao commentDao) {
        this.commentDao = commentDao;
    }

    public void addComment(Comment comment) throws Exception {
        checkCommentScore(comment.getScore());
        commentDao.save(comment);
    }
    public void checkCommentScore(int score) throws Exception {
        if(score < 1 || score > 5)
            throw new Exception("score must be between 1 to 5");
    }
}
