package project;

public class boardBean 
{
	int num; //게시글 번호
	String name; //성명
	String subject; //제목
	String content; //게시물 내용
	String regdate; //게시물 등록 날짜
	String filename; //파일명
	int filesize; //파일크기
	int count; //조회수
	String pass; //비밀번호
	int ref;
	int pos;
	int depth;
	String ip; //ip
	int recommand;
	
	public int getRecommand() {
		return recommand;
	}
	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}
	public int getDepth() 
	{
		return depth;
	}
	public void setDepth(int depth) 
	{
		this.depth = depth;
	}
	public String getIp() 
	{
		return ip;
	}
	public void setIp(String ip) 
	{
		this.ip = ip;
	}
	public int getRef() 
	{
		return ref;
	}
	public void setRef(int ref) 
	{
		this.ref = ref;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getNum() 
	{
		return num;
	}
	public void setNum(int num) 
	{
		this.num = num;
	}
	public String getName() 
	{
		return name;
	}
	public void setName(String name) 
	{
		this.name = name;
	}
	public String getSubject() 
	{
		return subject;
	}
	public void setSubject(String subject) 
	{
		
		this.subject = subject;
	}
	public String getContent() 
	{
		return content;
	}
	public void setContent(String content) 
	{
		this.content = content;
	}
	public String getRegdate() 
	{
		return regdate;
	}
	public void setRegdate(String regdate) 
	{
		this.regdate = regdate;
	}
	public String getFilename() 
	{
		return filename;
	}
	public void setFilename(String filename) 
	{
		this.filename = filename;
	}
	public int getFilesize() 
	{
		return filesize;
	}
	public void setFilesize(int filesize) 
	{
		this.filesize = filesize;
	}
	public int getCount() 
	{
		return count;
	}
	public void setCount(int count) 
	{
		this.count = count;
	}
	public String getPass() 
	{
		return pass;
	}
	public void setPass(String pass) 
	{
		this.pass = pass;
	}
}
