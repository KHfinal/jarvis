package kh.mark.jarvis.common;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class StringArrayType implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		// set으로 값을 집어넣을 때 pstmt.set(..)동작 부분을 정의하는 부분
		if(parameter!=null) {
			ps.setString(i, String.join(",", parameter));
		}
		else {
			ps.setString(i, "");
		}

	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		//rs.get할때 컬럼이름으로 가져오는 경우를 정의
	
		String columnValue=rs.getString(columnName);
		String[] columnArray=null;
		if(columnValue!=null) {
		 columnArray= columnValue.split(",");
		}
		return columnArray;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		// rs.get할때 컬럼 인덱스로 가져오는 경우를 정의
		String columnValue=rs.getString(columnIndex);
		String[] columnArray = columnValue.split(",");
		return columnArray;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
