INSERT INTO users (username, password) VALUES ("jordan", "password");
INSERT INTO receipts (upload_date, receipt_date, store, total_cost, comments, created_user_id, filename)
			VALUES(STR_TO_DATE("09/06/2016", '%m/%d/%Y'), STR_TO_DATE("09/06/2016", '%m/%d/%Y'),  "Costco", 571.43, "costco for lyfe", 1, "receipt_1.PDF"),
					(STR_TO_DATE("09/06/2016", '%m/%d/%Y'), STR_TO_DATE("09/06/2016", '%m/%d/%Y'),  "Home depot", 56.86, "Couldn't find the beer", 1, "receipt_1.PDF");