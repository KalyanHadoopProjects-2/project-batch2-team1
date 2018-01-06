package com.nareninfotech.task4;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.db.DBConfiguration;
import org.apache.hadoop.mapreduce.lib.db.DBInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import com.nareninfotech.mapreduce.DBInputWritable;

public class DbInputToXmlJob implements Tool {
	private Configuration conf;

	public Configuration getConf() {
		return conf;
	}

	public void setConf(Configuration conf) {
		this.conf = conf;
	}

	public int run(String[] args) throws Exception {
		DBConfiguration.configureDB(conf, "com.mysql.jdbc.Driver",
				"jdbc:mysql://localhost:3306/kalyan", "root", "hadoop");
		Job job = new Job(getConf());
		job.setJobName("Narendra DbInputToXml Job");
		job.setJarByClass(this.getClass());
		job.setMapperClass(DbInputToXmlMapper.class);
		job.setReducerClass(DbInputToXmlReducer.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		job.setInputFormatClass(DBInputFormat.class);
		job.setOutputFormatClass(XmlOutputFormat.class);
		DBInputFormat.setInput(job, DBInputWritable.class, "eventlog", null, null,
				new String[] {"id", "country","ip", "status"});
		Path output = new Path(args[0]);
		FileOutputFormat.setOutputPath(job, output);
		output.getFileSystem(conf).delete(output, true);
		return job.waitForCompletion(true) ? 0 : -1;
	}

	public static void main(String[] args) {
		try {
			int status = ToolRunner.run(new Configuration(),
					new DbInputToXmlJob(), args);
			System.out.println("Job Status: " + status);
		} catch (Exception e) {
			System.out.println("Exception received:" + e.getMessage());
		}
	}

}
