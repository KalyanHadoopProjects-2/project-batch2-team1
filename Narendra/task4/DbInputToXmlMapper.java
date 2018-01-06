package com.nareninfotech.task4;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import com.nareninfotech.mapreduce.DBInputWritable;

public class DbInputToXmlMapper extends
		Mapper<LongWritable, DBInputWritable, Text, IntWritable> {
	protected void map(LongWritable key, DBInputWritable value, Context context) {
		try {
			IntWritable id = new IntWritable(value.getId());
			String tostring = value.toString();
			context.write(new Text(tostring), id);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
