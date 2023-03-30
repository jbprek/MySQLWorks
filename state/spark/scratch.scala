val dfIn = spark.read.option("header", "true").option("inferSchema", "true").csv("data.csv")


dfIn.createOrReplaceTempView("in_tbl")

val dfT = spark.sql("select * from in_tbl")

val dfStateCount = spark.sql("select mpin,tin,state, count(state) as state_count from in_tbl group by mpin,tin,state")

dfStateCount.createOrReplaceTempView("state_count_by_mpst_view")

dfStateCount.show()

val dftStateCntNoTies = spark.sql("select mpin, tin, state_count from state_count_by_mpst_view group by mpin, tin, state_count having count(*) = 1")

dftStateCntNoTies.show()

dftStateCntNoTies.createOrReplaceTempView("state_max_count_no_ties_view")


val dfMostStateCountView =  spark.sql("select t1.mpin, t1.tin, t1.state_count from state_max_count_no_ties_view t1 inner join(select mpin, tin, max(state_count) as state_count from state_max_count_no_ties_view t2 group by mpin, tin ) t2 using(mpin, tin, state_count)")

dfMostStateCountView.show()

dfMostStateCountView.createOrReplaceTempView("state_most_state_count_view")


val dfMostState =  spark.sql("select mpin, tin, state from state_count_by_mpst_view l right outer join state_most_state_count_view r using(mpin, tin, state_count)")

dfMostState.show()

dfMostState.createOrReplaceTempView("state_most_view")

