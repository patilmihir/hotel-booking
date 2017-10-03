package com.mihir.bookingApp.model;


import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;


@Entity
public class User {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)	
	private long id;
	
	private String name;
	
	@Column(unique = true)
	private String username;
	
	private String password;
	private String email;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="manager", orphanRemoval = true)
	private Set<Hotel> hotels = new HashSet<Hotel>();
	
	@ManyToOne
	private Authority authority;
	
	public User() {}

	public User(String name, String username, String password, String email) {
		this.name = name;
		this.username = username;
		this.setPassword(password);
		this.setEmail(email);
	}


	public String getEmail() {
		return email;
	}
	
	public Set<Hotel> getHotels() {
		return hotels;
	}
	
	public long getId() {
        return id;
    }

    public String getName() {
		return name;
	}

    public String getPassword() {
		return password;
	}

	public String getUsername() {
        return username;
    }

	public void setEmail(String email) {
		this.email = email;
	}

	public void setHotels(Set<Hotel> hotels) {
		this.hotels = hotels;
	}

	public void setId(long id) {
        this.id = id;
    }

	public void setName(String name) {
		this.name = name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Authority getAuthority() {
		return authority;
	}

	public void setAuthority(Authority authority) {
		this.authority = authority;
	}

	public void setUsername(String username) {
        this.username = username;
    }

}
