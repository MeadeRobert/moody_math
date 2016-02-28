class Person {
  
  private double age;
  private double gender;
  private double education;
  
  public Person(int[] ageRegions, int[] educationRegions, int[] genderRegions)
  {
    int random = (int) (Math.random() * 1001);

    // Generate random age range
    for(int i = 0; i < ageRegions.length - 1; i++)
    {
      if(random >= ageRegions[i] && random <= ageRegions[i+1])
      {
        age = Age.values()[i].ordinal() + Math.random();
        break;
      }
    }
    
    // Generate random gender
    random = (int) (Math.random() * 1001);
    for(int i = 0; i < genderRegions.length - 1; i++)
    {
      if(random >= genderRegions[i] && random <= genderRegions[i+1])
      {
        gender = Gender.values()[i].ordinal();
        break;
      }
    }
    
    // Generate random valid education
    if(age < 1)
    {
      random = (int) (Math.random() * (educationRegions[2] + 1));
      for(int i = 0; i < 3; i++)
      {
        if(random >= educationRegions[i] && random <= educationRegions[i+1])
        {
          education = Education.values()[i].ordinal() + Math.random();
          break;
        }
      }
    }
    else
    {
      random = (int) (Math.random() * 1001);
      for(int i = 0; i < educationRegions.length - 1; i++)
      {
        if(random >= educationRegions[i] && random <= educationRegions[i+1])
        {
          education = Education.values()[i].ordinal() + Math.random();
          break;
        }
      }
    }
  }
  
  public double[] drive()
  {
    double[] data = new double[2];
    data[0] = ((31.658* Math.pow(education, .4073))
      + (1.2778 * Math.pow(age, 3) - 16.488 * Math.pow(age, 2) + 62.091 * age - 19)
      + (gender * 10 + 41))
      / 3.0;
    data[1] = ((-.8071 * Math.pow(education, 2) + 9.5329 * education + 10.52)
      + (.1812*Math.pow(age, 4) - 1.8292 * Math.pow(age, 3) + 2.4312*Math.pow(age, 2) + 14.585 * age + 4.25)
      + (8.7*gender + 24.9))
      / 3.0;
    return data;
  }
  
  public String toString()
  {
    return "[" + Age.values()[(int) age] + ", " +  Gender.values()[(int) gender] + ", " + Education.values()[(int) education] + "]";
  }
}