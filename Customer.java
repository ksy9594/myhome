package springHello;

//Customer 클래스
public class Customer 
{
	private long id;
	private String name;
	
	public long getid()
	{
		return id;
	}
	public void setid(long id)
	{
		this.id = id;
	}
	public String getname()
	{
		return name;
	}
	public void setname(String name)
	{
		this.name = name;
	}
	public String toString()
	{
		return "id : "+ id + "," + "name : "+name+".";
	}	
}
