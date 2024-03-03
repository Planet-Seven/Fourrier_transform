class Sum_wave extends Wave
{
  Sum_wave(int temp_position)
  {
     super(0);
     position = temp_position;
  }
  
  void update()
  {
    for (int i = 0; i < y_positions.length; i++)
    {
      float sum = 0;
      for ( int j = 0; j < waves.size(); j++ )
      {
         
         Wave wave = waves.get(j);
         sum += ( wave.y_positions[i] - wave.position );
         y_positions[i] = position + sum;
      }
    }
  }
  
  void render()
  {
    if (toggle == true)
    {
      stroke(primary);
      fill(primary);
    }
    else
    {
      stroke(secondary);
      fill(secondary);
    }
    
   for (int i = 0; i < y_positions.length; i++)
      circle( left_offset + i*circle_radius, y_positions[i] , circle_radius);
  }
}
