namespace MedCenterDB.DbObjects;

public class Rating : DbObject
{
    public User Patient { get; set; }
    public User Staffer { get; set; }
    public int RatingValue { get; set; }
    public DateTime RatingDateTime { get; set; } = DateTime.Now;
    public string RatingComment { get; set; }
}
