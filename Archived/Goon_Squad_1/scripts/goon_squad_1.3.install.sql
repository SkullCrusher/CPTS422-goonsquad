CREATE TABLE users (
	id	int	NOT NULL AUTO_INCREMENT,
    username VARCHAR(32),
    password VARCHAR(50),
    PRIMARY KEY(`id`)
);

CREATE TABLE receipts (
	id INT NOT NULL AUTO_INCREMENT,
	upload_date DATETIME,
	receipt_date DATETIME,
    store VARCHAR(32),
    total_cost DOUBLE,
    comments VARCHAR(300) NULL,
    created_user_id int,
	filename varchar(50) NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`created_user_id`) REFERENCES `users`(`id`)
		ON DELETE CASCADE
);

CREATE TABLE items (
	id INT NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(50) NOT NULL,
    item_cost DOUBLE,
    receipt_id INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`receipt_id`) REFERENCES `receipts`(`id`)
		ON DELETE CASCADE
);