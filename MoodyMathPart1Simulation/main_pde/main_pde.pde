public class Main
{

  public static void main(String[] args)
  {
    
    Person[] people = new Person[100];
    for(int i = 0; i < people.length; i++)
    {
      people[i] = new Person();
      System.out.println(people[i]);
      printArray(people[i].drive());
    }
    
    
    
    int numDays = 10;
    
    for(int i = 0; i < numDays; i++)
    {
      for(int j = 0; j < people.length; j++)
      {
        people[j].drive();
      }
    }
  }
  
  /**
  * The printArray method prints an int[] array in the format [a,b,c,...,n]
  * @param arr Array to print
  */
  public static void printArray(double[] arr)
  {
    String output = "[";
    for (double n : arr)
    {
      output += n + ",";
    }
    System.out.println(output.substring(0, output.length() - 1) + "]");
  }
}