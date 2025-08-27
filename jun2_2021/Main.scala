import org.apache.spark.{SparkConf, SparkContext}

object Main {
  def main(args: Array[String]):Unit = {
    val conf = new SparkConf()
      .setAppName("jun2_2024")
      .setMaster("local[4]")

    val sc = new SparkContext(conf)
    val res = sc.textFile("cars.csv")
      .filter(line => line.contains("AWD")
        && line.contains("Gasoline")
        && line.contains("5 Speed Automatic")
        && line.contains("6 Speed Automatic"))
      .map(linija => {
        val tokeni = linija.split(",")
        (tokeni(3), tokeni(8), tokeni(7))
      })
      .filter(kvp => kvp._2.toInt > 200 && kvp._3.toInt > 2010)
      .collect()

    var sum = 0
    var count = 0

    res.foreach(line => count += 1)
    if(count == 0)
      println("Nema")
    else
      println(sum.toDouble/count.toDouble)
  }
}