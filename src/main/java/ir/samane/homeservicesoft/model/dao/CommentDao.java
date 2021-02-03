package ir.samane.homeservicesoft.model.dao;

import ir.samane.homeservicesoft.model.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentDao extends JpaRepository<Comment, Integer> {
}
