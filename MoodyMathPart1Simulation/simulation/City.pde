public class City
{
  public String name;
  public int[] rgb;
  public ArrayList<Object[]> data;
  public ArrayList<Queue<Object[]>> buckets;
  public int[][] populationCategoriesRaw;
  public float[][] populationCategoriesPercent;
  
  private Person[] people;
  
  private int[] ageRegions;
  private int[] educationRegions;
  private int[] genderRegions;
  private int totalPopulation;
  
  public City(String name, int[] rgb, int[] ageRegions, int[] educationRegions, int[] genderRegions, int totalPopulation)
  {
    this.name = name;
    this.rgb = rgb;
    this.ageRegions = ageRegions;
    this.educationRegions = educationRegions;
    this.genderRegions = genderRegions;
    this.totalPopulation = totalPopulation;
    
    this.people = new Person[totalPopulation];
    for(int i = 0; i < totalPopulation; i++)
    {
      people[i] = new Person(ageRegions, educationRegions, genderRegions);
    }
    
    data = new ArrayList<Object[]>();
  }
  
  public void simulate()
  {
    for(Person p : people)
    {
      data.add(new Object[]{p, p.drive()});
    }
  }
  
  public void classify()
  {
    // declare sets of buckets
    ArrayList<Queue<Object[]>> buckets1 = new ArrayList<Queue<Object[]>>();
    ArrayList<Queue<Object[]>> buckets2 = new ArrayList<Queue<Object[]>>();
    
    for(int i = 0; i < 3; i++)
      buckets1.add(new LinkedList<Object[]>());
    for(int i = 0; i < 9; i++)
      buckets2.add(new LinkedList<Object[]>());
    
    // classify by time
    for(Object[] o : data)
    {
      double minutes = ((double[]) o[1])[0];
      if(minutes < lowerMidTime)
        buckets1.get(0).add(o);
      else if(minutes <= upperMidTime)
        buckets1.get(1).add(o);
      else
        buckets1.get(2).add(o);
    }
    
    // classify by distance
    for(int i = 0; i < buckets1.size(); i++)
    {
      while(buckets1.get(i).peek() != null)
      {
          double miles = ((double[]) buckets1.get(i).peek()[1])[1];
          if(miles < lowerMidDist)
            buckets2.get(i*3).add(buckets1.get(i).remove());
          else if(miles <= upperMidDist)
            buckets2.get(i*3+1).add(buckets1.get(i).remove());
          else
            buckets2.get(i*3+2).add(buckets1.get(i).remove());
      }
    }
    
    // set buckets of classifications
    this.buckets = buckets2;
    
    // calculate people in regions (raw values and percents of total)
    int length = (int) Math.round(Math.sqrt(buckets.size()));
    populationCategoriesRaw = new int[length][length];
    populationCategoriesPercent = new float[length][length];
    for(int i = 0; i < buckets.size(); i++)
    {
      populationCategoriesRaw[i / 3][i % 3] = buckets.get(i).size();
      populationCategoriesPercent[i / 3][i % 3] = (float) buckets.get(i).size() / (float) totalPopulation;
    }
  }
  
  public String toString()
  {
    String output = name + ":\n\nraw population:\n";
    
    for(int i = 0; i < populationCategoriesRaw.length; i++)
    {
      for(int j = 0; j < populationCategoriesRaw[0].length; j++)
        output += String.format("%d", populationCategoriesRaw[i][j]) + ", ";
      output = output.substring(0, output.length() - 2) + "\n";
    }
    
    
    output += "\npercent population:\n";
    
    for(int i = 0; i < populationCategoriesRaw.length; i++)
    {
      for(int j = 0; j < populationCategoriesRaw[0].length; j++)
        output += String.format("%.2f", populationCategoriesPercent[i][j] * 100) + ", ";
      output = output.substring(0, output.length() - 2) + "\n";
    }
    
    return output;
  }
}