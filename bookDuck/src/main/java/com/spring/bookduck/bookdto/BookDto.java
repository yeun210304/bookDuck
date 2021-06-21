package com.spring.bookduck.bookdto;
 
public class BookDto {
    private String title;
    private String link;
    private String coverLargeUrl;
    private String author;
    private Long priceStandard;
    private String publisher;
    private String pubdate;
    private String isbn;
    private String description;
    private String categoryId;
    
    public BookDto() {
	}

	public BookDto(String title, String link, String coverLargeUrl, String author, Long priceStandard, String publisher,
			String pubdate, String isbn, String description, String categoryId) {
		this.title = title;
		this.link = link;
		this.coverLargeUrl = coverLargeUrl;
		this.author = author;
		this.priceStandard = priceStandard;
		this.publisher = publisher;
		this.pubdate = pubdate;
		this.isbn = isbn;
		this.description = description;
		this.categoryId = categoryId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getCoverLargeUrl() {
		return coverLargeUrl;
	}

	public void setCoverLargeUrl(String coverLargeUrl) {
		this.coverLargeUrl = coverLargeUrl;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Long getPriceStandard() {
		return priceStandard;
	}

	public void setPriceStandard(Long priceStandard) {
		this.priceStandard = priceStandard;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPubdate() {
		return pubdate;
	}

	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	@Override
	public String toString() {
		return "Book [title=" + title + ", link=" + link + ", coverLargeUrl=" + coverLargeUrl + ", author=" + author
				+ ", priceStandard=" + priceStandard + ", publisher=" + publisher + ", pubdate=" + pubdate + ", isbn="
				+ isbn + ", description=" + description + ", categoryId=" + categoryId + "]";
	}
    
    
}

