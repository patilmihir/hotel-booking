package com.mihir.bookingApp.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Comment {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	private String text;
	private Date date;

	@ManyToOne
	private Hotel hotel;
		
	@ManyToOne
	private User user;

	public Comment() {}

	public Comment(String text, Date date, User user, Hotel hotel) {
		this.text = text;
		this.date = date;
		this.user = user;
		this.hotel = hotel;
	}

	public Date getDate() {
		return date;
	}

	public Hotel getHotel() {
		return hotel;
	}

	public long getId() {
		return id;
	}

	public String getText() {
		return text;
	}

	public User getUser() {
		return user;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setText(String text) {
		this.text = text;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
