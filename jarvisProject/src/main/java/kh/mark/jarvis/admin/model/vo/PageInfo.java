package kh.mark.jarvis.admin.model.vo;

public class PageInfo {
	private String headerCol;
	private String logoBagCol;
	private String logoFont;
	private int logoFontSize;
	private String iconCol;
	private String profileFont;
	private String menuBcol;
	private String menuCol;
	private String dropdownBcol;
	
	public PageInfo() {}
	
	public PageInfo(String headerCol, String logoBagCol, String logoFont, int logoFontSize, String iconCol,
			String profileFont, String menuBcol, String menuCol, String dropdownBcol) {
		super();
		this.headerCol = headerCol;
		this.logoBagCol = logoBagCol;
		this.logoFont = logoFont;
		this.logoFontSize = logoFontSize;
		this.iconCol = iconCol;
		this.profileFont = profileFont;
		this.menuBcol = menuBcol;
		this.menuCol = menuCol;
		this.dropdownBcol = dropdownBcol;
	}

	public String getHeaderCol() {
		return headerCol;
	}

	public void setHeaderCol(String headerCol) {
		this.headerCol = headerCol;
	}

	public String getLogoBagCol() {
		return logoBagCol;
	}

	public void setLogoBagCol(String logoBagCol) {
		this.logoBagCol = logoBagCol;
	}

	public String getLogoFont() {
		return logoFont;
	}

	public void setLogoFont(String logoFont) {
		this.logoFont = logoFont;
	}

	public int getLogoFontSize() {
		return logoFontSize;
	}

	public void setLogoFontSize(int logoFontSize) {
		this.logoFontSize = logoFontSize;
	}

	public String getIconCol() {
		return iconCol;
	}

	public void setIconCol(String iconCol) {
		this.iconCol = iconCol;
	}

	public String getProfileFont() {
		return profileFont;
	}

	public void setProfileFont(String profileFont) {
		this.profileFont = profileFont;
	}

	public String getMenuBcol() {
		return menuBcol;
	}

	public void setMenuBcol(String menuBcol) {
		this.menuBcol = menuBcol;
	}

	public String getMenuCol() {
		return menuCol;
	}

	public void setMenuCol(String menuCol) {
		this.menuCol = menuCol;
	}

	public String getDropdownBcol() {
		return dropdownBcol;
	}

	public void setDropdownBcol(String dropdownBcol) {
		this.dropdownBcol = dropdownBcol;
	}

	@Override
	public String toString() {
		return "PageInfo [headerCol=" + headerCol + ", logoBagCol=" + logoBagCol + ", logoFont=" + logoFont
				+ ", logoFontSize=" + logoFontSize + ", iconCol=" + iconCol + ", profileFont=" + profileFont
				+ ", menuBcol=" + menuBcol + ", menuCol=" + menuCol + ", dropdownBcol=" + dropdownBcol + "]";
	}
	
	
}
