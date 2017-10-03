package com.mihir.bookingApp.dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import com.mihir.bookingApp.exception.UserException;
import com.mihir.bookingApp.model.Authority;
import com.mihir.bookingApp.model.User;

public class UserDAO extends DAO {

	public User register(User u) throws UserException {
		try {
			begin();
			getSession().save(u);
			commit();
			return u;
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Exception while creating user: " + e.getMessage());
		}
	}

	public User get(String username, String password) throws UserException {
		try {
			begin();
			Query q = getSession().createQuery("from User where username = :username and password = :password");
			q.setString("username", username);
			q.setString("password", password);
			User user = (User) q.uniqueResult();
			commit();
			return user;
		} catch (HibernateException e) {
			rollback();
			throw new UserException("Could not get user " + username, e);
		}
	}

	public Authority getAuthorityByRole(String role) throws UserException {
		try {
			Query q = getSession().createQuery("from Authority WHERE role LIKE :value");
			q.setString("value", role);
			List<Authority> authority = q.list();
			return authority.get(0);

		} catch (HibernateException e) {
			rollback();
			throw new UserException("Cannot find User role.");
		}
	}

	public User findUser(long id) throws UserException {
		try {
			Query q = getSession().createQuery("from User WHERE id LIKE :value");
			q.setLong("value", id);
			User user = (User) q.uniqueResult();
			return user;

		} catch (HibernateException e) {
			rollback();
			throw new UserException("Cannot find User.");
		}
	}

	public boolean validateUsername(String username) {
		begin();
		Query q = getSession().createQuery("from User where username = :username");
		q.setString("username", username);
		List<User> users = q.list();
		if (users.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}

	public boolean validateEmail(String email) {
		begin();
		Query q = getSession().createQuery("from User where email = :email");
		q.setString("email", email);
		List<User> users = q.list();
		if (users.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}

}
