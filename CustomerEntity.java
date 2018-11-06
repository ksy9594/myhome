package springHello;

public class CustomerEntity 
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
	public Customer buildDomain()
	{
		Customer customer = new Customer();
		customer.setid(id);
		customer.setname(name);
		
		return customer;
	}
	public void buildEntity(Customer customer)
	{
		id = customer.getid();
		name = customer.getname();
	}
	

}
