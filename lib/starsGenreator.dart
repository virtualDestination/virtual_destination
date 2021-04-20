import 'dart:math';

String star = "⭐",stars="";
Random rng = new Random();

String ratingSys(){
  stars = "";

  for(int i=0;i<rng.nextInt(5)+1;i++){
    stars+=star;
  }

  return stars;
}