import java.util.*;

// variables for city data
int totalPopulation = 100000;
final int[] ageRegionsUS = new int[] {0, 86, 86+88, 86+88+85, 86+88+85+330, 86+88+85+330+243, 86+88+85+330+243+95, 1000};
final int[] genderRegionsUS = new int[] {0, 490, 1000};
final int[] educationRegionsUS = new int[]{0, 123, 123+296, 123+296+288, 123+296+288+189, 1000};
final int[] ageRegionsPoughkeepsie = new int[] {0, 86, 86+122, 86+122+96, 86+122+96+351, 86+122+96+351+171, 86+122+96+351+171+84, 1000};
final int[] genderRegionsPoughkeepsie = new int[] {0, 514, 1000};
final int[] educationRegionsPoughkeepsie = new int[]{0, 225, 225+256, 255+256+275, 255+256+275+129, 1000};
final int[] ageRegionsRichmond = new int[] {0, 86, 86+114, 86+114+102, 86+114+102+365, 86+114+102+365+170, 86+114+102+365+170+80, 1000};
final int[] genderRegionsRichmond = new int[] {0, 523, 1000};
final int[] educationRegionsRichmond = new int[]{0, 173, 173+238, 173+238+232, 173+238+232+213, 1000};
final int[] ageRegionsRiverside = new int[] {0, 121, 121+116, 121+116+98, 121+116+98+381, 121+116+98+381+163, 121+116+98+381+163+62, 1000};
final int[] genderRegionsRiverside = new int[] {0, 504, 1000};
final int[] educationRegionsRiverside = new int[]{0, 213, 213+242, 213+242+308, 213+242+308+142, 1000};
final int[] ageRegionsKnoxville = new int[] {0, 94, 94+143, 94+143+94, 94+143+94+332, 94+143+94+332+164, 94+143+94+332+164+83, 1000};
final int[] genderRegionsKnoxville = new int[] {0, 527, 1000};
final int[] educationRegionsKnoxville = new int[]{0, 108, 108+284, 108+284+303, 108+284+303+188, 1000};
ArrayList<City> cities = new ArrayList<City>();

// categorization values
//float lowerMidTime = 42.8;
//float upperMidTime = 49.9;
//float lowerMidDist = 26.8;
//float upperMidDist = 32.5;
float lowerMidTime = 38.2;
float upperMidTime = 46.3;
float lowerMidDist = 24.5;
float upperMidDist = 29.5;

// graphics data
float x1 = lowerMidTime * 10;
float x2 = upperMidTime * 10;
float y1 = lowerMidDist * 10;
float y2 = upperMidDist * 10;

// regions of age
enum Age
{
  Age16to19, Age20to24, Age25to29, Age30to49, Age50to64, Age65to74, Age75andOver
}
  
// binary choice of gender
enum Gender
{
  Female, Male
}

// levels of education
private enum Education
{
  GradeSchool, HighSchool, Associates, Bachelors, GraduateSchool
}
 
void setup()
{
  size(800, 600);
  fill(0);
  stroke(0);
  
  City unitedStates = new City("United States", new int[] {0,0,0}, ageRegionsUS, educationRegionsUS, genderRegionsUS, totalPopulation);
  unitedStates.simulate();
  unitedStates.classify();
  cities.add(unitedStates);
  System.out.println(unitedStates);
  
  City poughkeepsie = new City("Poughkeepsie", new int[] {255,0,0}, ageRegionsPoughkeepsie, educationRegionsPoughkeepsie, genderRegionsPoughkeepsie, totalPopulation);
  poughkeepsie.simulate();
  poughkeepsie.classify();
  //cities.add(poughkeepsie);
  //System.out.println(poughkeepsie);
  
  City richmond = new City("Richmond", new int[] {0,255,0}, ageRegionsRichmond, educationRegionsRichmond, genderRegionsRichmond, totalPopulation);
  richmond.simulate();
  richmond.classify();
  //cities.add(richmond);
  //System.out.println(richmond);
  
  City riverside = new City("Riverside",new int[] {0,0,255}, ageRegionsRiverside, educationRegionsRiverside, genderRegionsRiverside, totalPopulation);
  riverside.simulate();
  riverside.classify();
  //cities.add(riverside);
  //System.out.println(riverside);
  
  City knoxville = new City("Knoxville", new int[] {255,0,255}, ageRegionsKnoxville, educationRegionsKnoxville, genderRegionsKnoxville, totalPopulation);
  knoxville.simulate();
  knoxville.classify();
  //cities.add(knoxville);
  //System.out.println(knoxville);
}

void draw()
{
  background(155);
  
  //setup font
  PFont f = createFont("Sans Serif", 12, true);
  
  // draw data sets
  for(City c : cities)
  {
    stroke(c.rgb[0], c.rgb[1], c.rgb[2]);
    for(Object[] o : c.data)
    {
      point((float) ((double[]) o[1])[0] * 10, (float) ((double[]) o[1])[1] * 10);
    }
    textFont(f, 9);
    text(c.toString(), 700, 50);
  }
  
  stroke(0);
  fill(0);
   
  // draw axes labels
  textFont(f, 12);
  text("x axis -> (minutes)", 20, 10);
  rotate(radians(90));
  text("y axis -> (miles)", 30, -10);
  rotate(radians(-90));
  
  // label classification regions
  text("low", 200, 20);
  text("mid", 450, 20);
  text("high", 550, 20);
  text("low", 20, 200);
  text("mid", 20, 300);
  text("high", 20, 500);
  
  // draw lines of categorization
  line(x1, 0, x1, height);
  line(x2, 0, x2, height);
  line(0, y1, width, y1);
  line(0, y2, width, y2);
  
  // adjust lines of categorization
  if(keyPressed)
  {
    if(key == '1') x1 = mouseX;
    else if (key == '2') x2 = mouseX;
    else if (key == '3') y1 = mouseY;
    else if (key == '4') y2 = mouseY;
    else System.out.println(x1 + "," + x2 + "," + y1 + "," + y2);
  }
}

public static String arrayToString(double[] arr)
{
  String output = "[";
  for (double n : arr)
  {
    output += n + ",";
  }
  return output.substring(0, output.length() - 1) + "]";
}