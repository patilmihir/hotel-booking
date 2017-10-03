package com.mihir.bookingApp.dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import com.mihir.bookingApp.exception.CommentException;
import com.mihir.bookingApp.exception.UserException;
import com.mihir.bookingApp.model.Comment;

public class CommentDAO extends DAO{

	  public List<Comment> getComments(long userid) throws CommentException  {
	        try {
	           begin();            
	           Query q = getSession().createQuery("from Comment WHERE user_id LIKE :value");  
	           q.setString("value", String.valueOf(userid));
	           List<Comment> comments = q.list();
	           commit(); 
	           return comments;
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new CommentException("Cannot find user comments");
	       }
	    }
	  
	    public Comment getComment(long id) throws CommentException  {
	        try {
	           begin();            
	           Query q = getSession().createQuery("from Comment WHERE id LIKE :value");  
	           q.setString("value", String.valueOf(id));
	           List<Comment> comments = q.list();
	           commit(); 
	           return comments.get(0);
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new CommentException("Cannot find user comments");
	       }
	    }

		public void save(Comment comment) throws  CommentException {
			try {
				System.out.println("Reached comment block");
				begin();					
				getSession().save(comment);
				commit();
			} catch (HibernateException e) {
				rollback();
				throw new CommentException("Exception while saving comment: " + e.getMessage());
			}	
		}
	  
}
