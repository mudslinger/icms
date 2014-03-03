module FeedbacksHelper
    TIME_OPTS = [
    ["9:00-10:00",9],
    ["10:00-11:00",10],
    ["11:00-12:00",11],
    ["12:00-13:00",12],
    ["13:00-14:00",13],
    ["14:00-15:00",14],
    ["15:00-16:00",15],
    ["16:00-17:00",16],
    ["17:00-18:00",17],
    ["18:00-19:00",18],
    ["19:00-20:00",19],
    ["20:00-21:00",20],
    ["21:00-22:00",21],
    ["22:00-23:00",22],
    ["23:00- 0:00",23],
    [" 0:00- 1:00",0],
    [" 1:00- 2:00",1],
    [" 2:00- 3:00",2],
    [" 3:00- 4:00",3],
    [" 4:00- 5:00",4],
    [" 5:00- 6:00",5],
    [" 6:00- 7:00",6],
    [" 7:00- 8:00",7],
    [" 8:00- 9:00",8]
  ].freeze
  REP_OPTS = [
    ["初めて",0],
    ["1年に1回程度",1],
    ["半年に1回程度",2],
    ["3ヶ月に1回程度",4],
    ["月に1回程度",12],
    ["月に2回程度",24],
    ["週に1回程度",48],
    ["週に2回程度",96],
    ["週に3回以上",180]
  ].freeze
  AGE_OPTS = [
   ["15-19歳", 15],
   ["20-24歳", 20],
   ["25-29歳", 25],
   ["30-34歳", 30],
   ["35-39歳", 35],
   ["40-44歳", 40],
   ["45-49歳", 45],
   ["50-54歳", 50],
   ["55-59歳", 55],
   ["60-64歳", 60],
   ["65-69歳", 65],
   ["70歳以上", 70]
  ].freeze

  def age_opts
    AGE_OPTS
  end
  def rep_opts
    REP_OPTS
  end
  def time_opts
    TIME_OPTS
  end
end