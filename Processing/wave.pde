public class Wave
{
  float frequency; 
  int position;
  int number;
  float[] y_positions = new float[circle_count];
  
  Wave( int temp_position )
  {
    frequency = random(lower, upper);
    number = temp_position;
    position = top_offset + temp_position * wave_offset;
  }
  
  void update()
  {
    for (int i = 0; i < y_positions.length; i++)
      {
        if ( frequency == 0 )
          y_positions[i] = position;
        else
          y_positions[i] = position + amplitude * sin(i*frequency + phase);
      }
  }
  
  void render()
  {
    if ( (toggle == true && match != number) || toggle == false )
    {
      stroke(secondary);
      fill(secondary);
    }
    else
    {
      stroke(primary);
      fill(primary);
    }
    
    for (int i = 0; i < y_positions.length; i++)
      circle( left_offset + i*circle_radius, y_positions[i] , circle_radius);
  }
}
