package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;



public class CommentMgr 
{
	DBConnectionMgr pool;
	
	public CommentMgr()
	{
		pool = DBConnectionMgr.getInstance();		
	}
	
	//Comment Insert
		public void insertComment(CommentBean bean)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert comment(name,comment,regdate,num) "
						+ "values(?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getName());
				pstmt.setString(2, bean.getComment());
				pstmt.setInt(3, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		//Comment List
		public Vector<CommentBean> getComment(int num)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			 Vector<CommentBean> vlist = new Vector<CommentBean>();
			try {
				con = pool.getConnection();
				sql = "select * from comment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					CommentBean bean = new CommentBean();
					bean.setCnum(rs.getInt("cnum"));
					bean.setName(rs.getString("name"));
					bean.setComment(rs.getString("comment"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setNum(rs.getInt("num"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//Comment Delete
		public void deleteComment(int cnum)
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try 
			{
				con = pool.getConnection();
				sql = "delete from comment where cnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.executeUpdate();
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
}
