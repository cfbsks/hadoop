import java.io.IOException;
import java.io.InputStream;

import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;

public class MyFSDataInputStream extends FSDataInputStream {

  public MyFSDataInputStream(InputStream in) throws IOException {
    super(in);
  }

  public String readLine() throws IOException {
    StringBuilder sb = new StringBuilder();
    int ch;
    while ((ch = read()) != -1) {
      if (ch == '\n') {
        break;
      }
      sb.append((char) ch);
    }
    if (sb.length() == 0 && ch == -1) {
      return null;
    }
    return sb.toString();
  }

  public static void main(String[] args) throws IOException {
    Configuration conf = new Configuration();
    conf.set("fs.defaultFS", "hdfs://localhost:9000");
    FileSystem fs = FileSystem.get(conf);
    Path path = new Path("/upload/init.sh");
    MyFSDataInputStream in = new MyFSDataInputStream(fs.open(path));
    String line;
    while ((line = in.readLine()) != null) {
      System.out.println(line);
    }
    in.close();
  }
}
