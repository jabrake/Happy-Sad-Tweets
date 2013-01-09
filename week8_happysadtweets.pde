//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> happyWords = new ArrayList();
ArrayList<String> sadWords = new ArrayList();

String happyTweets = "";
String sadTweets = "";

void setup() {
  size(900, 600);
  background(0);
  smooth();
  
  //Draw line to split screen in two horizontally
  stroke(255);
  strokeWeight(5);
  line(0, height/2, width, height/2);

  //Draw buttons
  fill(255);
  rectMode(CENTER);
  rect(50, 150, 50, 50);
  rect(50, 450, 50, 50);
  fill(0);
  textSize(50);
  text(":)", 35, 165);
  text(":(", 35, 465);

  //Twitter Credentials
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("EyK85zjxfMoYNo3GJmLH0A");
  cb.setOAuthConsumerSecret("0hOo5MgpiMHodYtHubK8NHvcviv581rHRT3vJwTyZc");
  cb.setOAuthAccessToken("57089769-Mfu2XL5zI4nH1V8p3eN74A9jpolQMleB6qsZein3A");
  cb.setOAuthAccessTokenSecret("dnUZoXLpbGD8LC06n7KNq2DshiTlyFQbSVx04E");

  //Make the twitter object and prepare the query
  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query happyQuery = new Query("&#34; :) &#34;");
  Query sadQuery = new Query("&#34; :( &#34;");
  happyQuery.setRpp(100);
  sadQuery.setRpp(100);

  //Try making the happy query request.
  try {
    QueryResult result = twitter.search(happyQuery);
    ArrayList tweets = (ArrayList) result.getTweets();

    for (int i = 0; i < tweets.size(); i++) {
      Tweet t = (Tweet) tweets.get(i);
      String user = t.getFromUser();
      String msg = t.getText();
      Date d = t.getCreatedAt();
      println("Tweet by " + user + " at " + d + ": " + msg);

      happyWords.add(msg);
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };

  //Try making the sad query request.
  try {
    QueryResult result = twitter.search(sadQuery);
    ArrayList tweets = (ArrayList) result.getTweets();

    for (int i = 0; i < tweets.size(); i++) {
      Tweet t = (Tweet) tweets.get(i);
      String user = t.getFromUser();
      String msg = t.getText();
      Date d = t.getCreatedAt();
      println("Tweet by " + user + " at " + d + ": " + msg);

      sadWords.add(msg);
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };
}

void draw() {
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(0, 2);
  rectMode(CORNER);
  noStroke();
  rect(100, 100, 800, 100);
  rect(100, 400, 800, 100);

  //Draw a Tweet from the list of Tweets that we've built
  int a = (frameCount % happyWords.size());
  happyTweets = happyWords.get(a);

  int b = (frameCount % sadWords.size());
  sadTweets = sadWords.get(b);
  
}

void mouseClicked() {
  if ((mouseX > 25) && (mouseX < 75) && (mouseY > 125) && (mouseY < 175)) {
    fill(255);
    textSize(15);
    text(happyTweets, 150, 160);
  }

  if ((mouseX > 25) && (mouseX < 75) && (mouseY > 425) && (mouseY < 475)) {
    fill(255);
    textSize(15);
    text(sadTweets, 150, 460);
  }
}
