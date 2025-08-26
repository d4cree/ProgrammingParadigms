import org.apache.spark.{SparkConf, SparkContext}

object Main {
  def main(args: Array[String]):Unit = {
    val conf = new SparkConf()
      .setAppName("jun1_2024")
      .setMaster("local[4]")

    val sc = new SparkContext(conf)
    val res = sc.textFile("izvodjaci.csv")
      .filter(linija => linija.contains("Rock"))
      .map(linija => {
        val tokeni = linija.split(",")
        (tokeni(3), tokeni(2).toDouble)
      })
      .groupByKey()
      .map(kvp => {
        var count = 0
        var suma = 0.0
        kvp._2.foreach(number =>
          suma += number
        )
        kvp._2.foreach(number =>
          count += 1
        )

        (kvp._1, suma/count.toDouble)
      })
      .sortByKey()
      .collect()


    res.foreach(line => println(line._1, line._2))
  }
}

