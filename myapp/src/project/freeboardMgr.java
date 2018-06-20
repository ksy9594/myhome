package project;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class freeboardMgr 
{
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Users/ksy/workspace/myapp/WebContent/ProjectFolder/web/fileuploadimg/";
	public static final String ENCTYPE = "UTF-8";
	public static final int MAXSIZE = 5*1024*1024;
	
	public freeboardMgr()
	{
		try
		{
			pool = DBConnectionMgr.getInstance();			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public Vector<freeboardBean> getBoardList(String keyField, String keyWord, int start, int end)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<freeboardBean> vlist = new Vector<>();
		
		try
		{
			con = pool.getConnection();
			
			if(keyWord.equals("null")|| keyWord.equals(""))
			{
				sql = "select *from freeboardwrite order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);				
			}
			else
			{
				sql = "select * from freeboardwrite where "+ keyField + " like ? "
						 + "order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				freeboardBean bean = new freeboardBean();
				bean.setNum(rs.getInt("num")); //게시글번호
				bean.setName(rs.getString("name")); //작성자
				bean.setSubject(rs.getString("subject")); //글 제목
				bean.setContent(rs.getString("content")); //글 내용
				bean.setRegdate(rs.getString("regdate")); //작성일
				bean.setCount(rs.getInt("count")); //조회수
				bean.setFilename(rs.getString("filename")); //파일이름
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				vlist.addElement(bean);
			}		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;	
	}
	public int getTotalCount(String keyField, String keyWord) //게시글 숫자 카운트, 게시물 번호
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int totalCount = 0;
		
		try
		{
			con = pool.getConnection();
			if(keyWord.equals("null")||keyWord.equals(""))
			{
				sql = "select count(*) from freeboardwrite";
				pstmt = con.prepareStatement(sql);
			}
			else
			{
				sql = "select count(*) from freeboardwrite where "+ 
							keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	public void insertBoard(HttpServletRequest req)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
						
		try
		{
			con = pool.getConnection();
			sql = "select max(ref) from freeboardwrite";
			pstmt = con.prepareStatement(sql);
			int ref = 1;
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				ref = rs.getInt(1)+1;
				
				File dir = new File(SAVEFOLDER);
				
				if(!dir.exists())
				{
					dir.mkdirs(); //폴더 생성
				}
				MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE,ENCTYPE, 
						new DefaultFileRenamePolicy());
				
				String filename = null; //만약 파일업로드를 하지 않았다면 널값과 0이 저장된다.
				int filesize = 0;
				
				if(multi.getFilesystemName("filename") != null)
				{
					filename = multi.getFilesystemName("filename");
					filesize = (int)multi.getFile("filename").length();
				}
				String content = multi.getParameter("content");
				
				sql = "insert freeboardwrite(name,subject,content,regdate,filename,filesize,count,pass,ref,pos,ip)"
						+ "values (?,?,?,now(),?,?,0,?,?,0,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("subject"));
				pstmt.setString(3, content);
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setString(6, multi.getParameter("pass"));
				pstmt.setInt(7, ref);
				pstmt.setString(8, multi.getParameter("ip"));
				
				pstmt.executeUpdate();				
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			pool.freeConnection(con, pstmt, rs);
		}
		return;
	}
			//Board upCount ->조회수
			public void upCount(int num) 
			{
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					
					try 
					{
						con = pool.getConnection();
						sql = "update freeboardwrite set count=count+1 where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
					} 
					catch (Exception e) 
					{
						e.printStackTrace();
					} 
					finally 
					{
						pool.freeConnection(con, pstmt);
					}
			}
			//Board Read
			public freeboardBean getBoard(int num)  //게시글 가져오기
			{
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				freeboardBean bean = new freeboardBean();
						
				try 
				{
					con = pool.getConnection();
					sql = "select * from freeboardwrite where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
							
					if (rs.next()) 
					{
						bean.setNum(rs.getInt("num"));
						bean.setName(rs.getString("name"));
						bean.setSubject(rs.getString("subject"));
						bean.setContent(rs.getString("content"));
						bean.setPos(rs.getInt("pos"));
						bean.setRef(rs.getInt("ref"));
						bean.setDepth(rs.getInt("depth"));
						bean.setRegdate(rs.getString("regdate"));
						bean.setPass(rs.getString("pass"));
						bean.setCount(rs.getInt("count"));
						bean.setFilename(rs.getString("filename"));
						bean.setFilesize(rs.getInt("filesize"));
						bean.setIp(rs.getString("ip"));
					}
						} 
						catch (Exception e) 
						{
							e.printStackTrace();
						} 
						finally 
						{
							pool.freeConnection(con, pstmt, rs);
						}
						return bean;
				}
			public void updateboard(String name,String subject,String content,String filename, int num) //파일 수정
			{
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
							
				try
				{
					con = pool.getConnection();
					sql ="update freeboardwrite set name=?,subject=?, content=?, filename=? where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, name);
					pstmt.setString(2, subject);
					pstmt.setString(3, content);
					pstmt.setString(4, filename);
					pstmt.setInt(5, num);
					
					pstmt.executeUpdate();
					
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				} 
				finally 
				{
					pool.freeConnection(con, pstmt);
				}
			}
			//Board Delete ->게시물 삭제
			public void deleteBoard(int num) 
			{
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				ResultSet rs = null;
						
				try 
				{
					con = pool.getConnection();
					sql = "select filename from freeboardwrite where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if (rs.next() && rs.getString(1) != null) 
					{
						if (!rs.getString(1).equals("")) 
						{
							File file = new File(SAVEFOLDER + "/" + rs.getString(1));
							if (file.exists())
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
						}
					}
					sql = "delete from freeboardwrite where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				} 
				catch (Exception e) 
				{
					e.printStackTrace();
				} 
				finally 
				{
					pool.freeConnection(con, pstmt, rs);
				}
			}
			//Board Download
			public void downLoad(HttpServletRequest req, HttpServletResponse res,
					JspWriter out,PageContext pageContext)
			{
				try 
				{
					//요청객체인 req에서 다운로드 파일명을 문자열로 리턴 받는다.
					String filename = req.getParameter("filename");
					//저장된 경로와 다운로드 파일명을 합쳐서 File 객체를 생성한다. 
					File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename));
					//파일의 용량 크기 만큼 byte 배열을 선언한다. 
					byte b[] = new byte[(int) file.length()];
					//응답 객체 res 헤더필드에 Accept-Ranges에 bytes 단위로 설정한다.
					res.setHeader("Accept-Ranges", "bytes");
					//요청객체인 req에서 클라이언트의 User-Agent 정보를 리턴 받는다.
					String strClient = req.getHeader("User-Agent");
					//브라우저의 버전과 정보를 구분해서 각각 res 헤더필드와 contentType을 설정한다.
					
					if (strClient.indexOf("MSIE6.0") != -1) 
					{
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "filename=" + filename + ";");
					} 
					else 
					{
						res.setContentType("application/smnet;charset=UTF-8");
						res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
					}
					out.clear();
					out = pageContext.pushBody();
					
					//파일 존재 여부에 따라 스트링 방식으로 브라우저로 파일을 전송한다.
					if (file.isFile()) 
					{
						BufferedInputStream fin = new BufferedInputStream(
								new FileInputStream(file));
						BufferedOutputStream outs = new BufferedOutputStream(
								res.getOutputStream());
						int read = 0;
						
						while ((read = fin.read(b)) != -1) 
						{
							outs.write(b, 0, read);
						}
						outs.close();
						fin.close();
					}
				} catch (Exception e) 
				{
					e.printStackTrace();
				}
			}
}
