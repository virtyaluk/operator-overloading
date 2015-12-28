using static System.Diagnostics.Debug;

namespace OperatorOverloading
{
	public struct Vector
	{
		public int X;
		public int Y;
		
		public Vector(int x = 0, int y = 0)
		{
			X = x;
			Y = y;
		}
		
		public static Vector operator +(Vector left, Vector right)
			=> new Vector(left.X + right.X, left.Y + right.Y);
		
		public static Vector operator -(Vector left, Vector right)
			=> new Vector(left.X - right.X, left.Y - right.Y);
	}
	
	public static class Program
	{
		public static void Main()
		{
			var v1 = new Vector(3, 4);
			var v2 = new Vector(6, 7);
			
			Assert((v1 + v2).X == 9 && (v1 + v2).Y == 11, "Condition not true.");
			Assert((v2 - v1).X == 3 && (v2 - v1).Y == 3, "Condition not true.");
		}
	}
}