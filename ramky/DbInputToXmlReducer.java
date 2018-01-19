package com.nareninfotech.task4;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class DbInputToXmlReducer extends Reducer<Text, IntWritable, Text, IntWritable>{
	protected void reduce(Text key, IntWritable value, Context context)
			throws IOException, InterruptedException {
		context.write(new Text(key), value);
	}

}
