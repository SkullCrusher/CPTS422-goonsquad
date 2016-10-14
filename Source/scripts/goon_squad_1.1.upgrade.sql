ALTER TABLE `receipts`
	ADD created_user_id int;
ALTER TABLE `receipts`
    Add FOREIGN KEY (`created_user_id`) REFERENCES `users`(`id`)
		ON DELETE CASCADE;