package HeaderFlagMapping;

import java.util.HashMap;

public class HeaderFlagHash
{
	private static HashMap<Integer, String> hashFlag;
	

	static {
		hashFlag = new HashMap<Integer, String>();
		hashFlag.put(1, "japanFlag.svg");
		hashFlag.put(2, "vietnamFlag.png");
		hashFlag.put(3, "hungaryFlag.png");
		hashFlag.put(4, "polandFlag.png");
	}
	
	  public static HashMap<Integer, String> gethashFlag()
	  {
		  return hashFlag;
	  }
}
