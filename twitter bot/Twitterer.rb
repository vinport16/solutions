require "oauth"
require "twitter"
require "yaml"

class Array
  def repeats?
    arr=[]
    self.each do |q|
      if !arr.include?(q)
        arr<<q
      else
        raise "The instance #{q} was repeated."
      end
    end
  end
  def delete instance
    i=self.length
    while i >= 0
      if self[i] == instance
        self.delete_at(i)
      end
      i=i-1
    end
  end
end

adj=["funky","abnormal","jealous","silent","spunky","government-employed","two-faced","intrisnic","artificial","authentic","odd","delusional","backwards","broken","wild","translucent","tensile","solid","sticky","sensable","odorless","loud","gentle","strong","potent","cute","zesty","pulpy","sparkley","brown","wet","warm","moist","damp","hot","exothermal","lukewarm","lengthy","resentful","armless","flightless","one-toed","ambidexterous","tickleish","fluffy","cutie-putootie","murky","moldy","blubbery","tall","short","babby","sugary","sweet","sour","chunky","green","purple","jacked","swole","milky","watered-down","soupy","thick","woolen","nasty","squeaky-clean","thirsty","starved","thirst-quenching","famished","swashbuckling","dark","holy","round","fantastic","humble","ammused","viscous","germophobic","claustrophobic","disgusting","teency-weency"]
noun=["rock","ape","man","code","chuckle","eagle","foot","Earl of Sandwich","pyramid","charity","cherry","glue","textbook","knife","cat","dragon","Saturn","subwoofer","France","Canada","bean","trinket","Oldsmobile","pretzel","left hand","baseball","mop","moth","sass","freedom","liberty","ghost","waffle pile","pile of waffles","bottle","BLT","brick","troll","cup of juice","wad of cash","bookshelf","chef","rotten bananna","pumpkin","squirrel","cardboard box","Fender-Telecaster","drumkit","zombie","oasis","kangaroo","marsupial","bicycle","tricycle","slushee machine","pot 'o glue","thundercloud","tounge","eyeball","clock","vending machine","stranger","uncle","parsnip","cow","pair of scissors","pair of pants","pair of binoculars","toddler","stampede","spartan","Orville Wright","Vermont","California"]
verb=["ran away","is funded by the government","is only an illusion","will never see you again","is in need of funding","could use one #{noun[rand(noun.length)]}","is coming your way","couldn't be better","can't quite fathom its own existance","is its own worst enemy","should be making you more nervous","is faster than you","chopped through the underbrush","breaks a board","swam a mile","crossed the bridge","sharded in the bathtub","stuck to your ceiling","is right behind you","says 'do not make any sudden movements'","says, 'eat a brick'","doesn't eat moss","is soaked with syrup","crossed the line","swims swiftly","dropped a "+noun[rand(noun.length)],"raked some leaves","shoveled the snow","read your book","plays runescape","minds your buisness","snagged a sandwich","went fishing","passed the bon-bons","poured cement","feels really terrible","goes to school","slips up sometimes","loves the relaxing mood","does a SLAM-DUNK","let a single tear trickle","is afraid of folding socks","can't bear canned vegetables","is your one and only friend","possesses nuclear capability","has an alpaca farm","lives in the U.K.","just won an award","keeps a coin collection","has every state quarter","used to live in your attic","just made a bank account","ice-skated","jumped rope for an hour","makes a rocking horse","has elves working for him","sniffed the roses","praises the Lord","did the unthinkable","did the impossible","lives on the moon","cannot be real"]
sym=[".",".",".",".",".",".","!","?","?!"]

adj.repeats?
noun.repeats?
verb.repeats?

auth = YAML.load(File.open('auth.yaml'))

while true
  
  client = Twitter::REST::Client.new do |config|
      config.consumer_key = auth["consumer_key"].to_s
      config.consumer_secret = auth["consumer_secret"].to_s
      config.access_token = auth["token"].to_s
      config.access_token_secret = auth["token_secret"].to_s
  end
  
  q=rand(4)
  if q == 0
    string="The #"+adj[rand(adj.length)]+" #"+noun[rand(noun.length)]+" "+verb[rand(verb.length)]+sym[rand(sym.length)]
  elsif q == 1
    string=adj[rand(adj.length)]+" #"+noun[rand(noun.length)]+" "+verb[rand(verb.length)]+sym[rand(sym.length)]
    if string[0]=="a"||string[0]=="e"||string[0]=="i"||string[0]=="o"||string[0]=="u"
      string="An #"+string
    else
      string="A #"+string
    end
  elsif q == 2
    string="My #"+adj[rand(adj.length)]+" #"+noun[rand(noun.length)]+" "+verb[rand(verb.length)]+sym[rand(sym.length)]
  elsif q == 3
    string="Your #"+adj[rand(adj.length)]+" #"+noun[rand(noun.length)]+" "+verb[rand(verb.length)]+sym[rand(sym.length)]
  end
  
  #adds in a random link from a file of links (not included)
  #file = File.new("links.txt","r")
  #bling=file.read.split("\n")
  #string=string+"\n"+bling[rand(bling.length)]+"\n"
  #file.close
  
  puts
  puts string
  puts
  
  client.update(string)
  
  num=(rand(15)+rand(20))*60
  while num > 0
    puts "#{num/60/60}:#{(num/60%60)} left"
    sleep(60)
    num=num-60
  end
  
end

