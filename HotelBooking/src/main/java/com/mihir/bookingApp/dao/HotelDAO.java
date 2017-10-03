package com.mihir.bookingApp.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import com.mihir.bookingApp.exception.HotelException;
import com.mihir.bookingApp.model.Hotel;
import com.mihir.bookingApp.model.RoomType;


public class HotelDAO extends DAO{
	   public List<Hotel> getHotels() throws HotelException{
	        try {
	           begin();            
	           Query q = getSession().createQuery("from Hotel");           
	           List<Hotel> hotels = q.list();
	           commit(); 
	           return hotels;
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new HotelException("Cannot find hotels");
	       }
	    }
	   
	   public Hotel getHotel(long id) throws HotelException{
	        try {
	           begin();            
	           Query q = getSession().createQuery("from Hotel WHERE id LIKE :value"); 
	           q.setString("value", String.valueOf(id));
	           List<Hotel> hotels = q.list();
	           commit(); 
	           return hotels.get(0);
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new HotelException("Cannot find hotel");
	       }
	    }
	   
	   
	   public List<Hotel> getHotelByName(String keyword) throws HotelException{
	        try {
	              
	           Query query = getSession().createQuery("from Hotel WHERE name LIKE :value");
	           query.setString("value", "%"+keyword+"%");
	           List<Hotel> hotels = query.list();
	           return hotels;
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new HotelException("Cannot find hotel");
	       }
	    }

	   public List<RoomType> getRoomTypes() throws HotelException {
		   try {
	           begin();            
	           Query q = getSession().createQuery("from RoomType"); 
	           List<RoomType> roomTypes = q.list();
	           commit(); 
	           return roomTypes;
	           
	       } catch (HibernateException e) {
	           rollback();
	           throw new HotelException("Cannot find room type");
	       }
	   }
}
