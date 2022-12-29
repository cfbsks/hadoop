import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MergeAndDeduplicate {

  public static class DeduplicateMapper
       extends Mapper<Object, Text, Text, Text>{

    private Text word = new Text();

    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
      word.set(value);
      context.write(word, new Text(""));
    }
  }

  public static class DeduplicateReducer
       extends Reducer<Text,Text,Text,Text> {
    private static final Text emptyText = new Text("");
    private Set<String> uniqueWords = new HashSet<String>();

    public void reduce(Text key, Iterable<Text> values,
                       Context context
                       ) throws IOException, InterruptedException {
      String word = key.toString();
      if (!uniqueWords.contains(word)) {
        uniqueWords.add(word);
        context.write(key, emptyText);
      }
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    conf.set("fs.default.name","hdfs://localhost:9000");
    Job job = Job.getInstance(conf, "merge and deduplicate");
    job.setJarByClass(MergeAndDeduplicate.class);
    job.setMapperClass(DeduplicateMapper.class);
    job.setReducerClass(DeduplicateReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileInputFormat.addInputPath(job, new Path(args[1]));
    FileOutputFormat.setOutputPath(job, new Path(args[2]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
