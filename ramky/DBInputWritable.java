package com.nareninfotech.task4;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapreduce.lib.db.DBWritable;

public class DBInputWritable implements Writable, DBWritable {
	private int id;
	private String country, ip, status;

	public void readFields(DataInput in) throws IOException {
	}

	public void readFields(ResultSet rs) throws SQLException {
		id = rs.getInt(1);
		country = rs.getString(2);
		ip = rs.getString(3);
		status = rs.getString(4);
	}

	public void write(DataOutput out) throws IOException {
	}

	public void write(PreparedStatement ps) throws SQLException {
		ps.setInt(1, id);
		ps.setString(2, country);
		ps.setString(3, ip);
		ps.setString(4, status);
	}

	public int getId() {
		return id;
	}

	public String getCountry() {
		return country;
	}

	public String getIp() {
		return ip;
	}

	public String getStatus() {
		return status;
	}

	public String toString() {
		return id + "," + country + "," + ip + "," + status;
	}
}
