package HeaderFlagMapping;

import java.util.HashMap;

public class HeaderFlagHash
{
	private static HashMap<Integer, String> hashCourse;
	private static HashMap<Integer, String> hashFlag;
	

	static {
		hashCourse = new HashMap<Integer, String>();
		hashCourse.put(1, "일본");
		hashCourse.put(2, "베트남");
		hashCourse.put(3, "헝가리");
		hashCourse.put(4, "폴란드");
		
		hashFlag = new HashMap<Integer, String>();
		hashFlag.put(1, "japanFlag.svg");
		hashFlag.put(2, "vietnamFlag.png");
		hashFlag.put(3, "hungaryFlag.png");
		hashFlag.put(4, "polandFlag.png");
	}
	
	  public static HashMap<Integer, String> gethashCourse()
	  {
		  return hashCourse;
	  }
	  
	  public static HashMap<Integer, String> gethashFlag()
	  {
		  return hashFlag;
	  }

}
