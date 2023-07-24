Bài 2:

-- Hiển thị toàn bộ nội dung của bảng Architect
-- SELECT * FROM `architect` 
-- Hiển thị danh sách gồm họ tên và giới tính của Kiến trúc sư
-- SELECT name, sex FROM `architect`;
-- Hiển thị năm sinh của Kiến trúc sư
-- SELECT birthday FROM `architect`;
-- Hiển thị danh sách gồm họ tên và năm sinh của Kiến trúc sư (giá trị năm sinh tăng dần)
-- SELECT name, birthday FROM `architect` ORDER BY birthday ASC;
-- Hiển thị danh sách gồm họ tên và năm sinh của Kiến trúc sư (giá trị năm sinh giảm dần)
-- SELECT name, birthday FROM `architect` ORDER BY birthday DESC;

-- Hiển thị danh sách các công trình có chi phí từ thấp đến cao. Nếu 2 công trình có chi phí bằng nhau thì sắp xếp tên thành phố theo bảng chữ cái:
-- SELECT name, cost FROM `building`ORDER BY cost ASC; 

Bài 4:

-- Hiển thị tất cả thông tin của Kiến trúc sư "Lê Thanh Tùng":
-- SELECT * FROM `architect` WHERE name = 'le thanh tung'
-- Hiển thị tên và năm sinh các công nhân có chuyên môn hàn hoặc điện:
-- SELECT name, birthday FROM `worker` WHERE skill = 'han' OR skill = 'dien'
-- Hiển thị tên và năm sinh các công nhân có chuyên môn hàn hoặc điện:
-- SELECT name, birthday FROM `worker` WHERE skill = 'han' OR skill = 'dien'
-- Hiển thị tên các công nhân có chuyên môn hàn hoặc điện và năm sinh lớn hơn năm 1948:
-- SELECT name FROM `worker` WHERE skill = 'han' OR skill = 'dien' AND birthday > 1948
-- Hiển thị những công nhân bắt đầu vào nghề khi dưới 20 tuổi (birthday + 20 > year):
-- SELECT name FROM `worker` WHERE year - birthday < 20
-- Hiển thị những công nhân có năm sinh 1940, 1945 và 1948:
SELECT name FROM `worker` WHERE birthday IN ('1940', '1945', '1948')
-- Tìm những công trình có chi phí đầu từ từ 200 đến 500 triệu đồng:
-- SELECT name FROM `building` WHERE cost BETWEEN '200' AND '500'
-- Tìm kiếm những Kiến trúc sư có họ là Nguyễn:
-- SELECT name FROM `architect` WHERE name LIKE '%nguyen%'
-- Tìm kiếm những Kiến trúc sư có tên đệm là Anh:
SELECT name FROM `architect` WHERE name LIKE '% anh%'
-- Tìm kiếm những Kiến trúc sư có tên bắt đầu th và có 3 ký tự:
-- SELECT * FROM `architect` WHERE name LIKE '%th_' 
-- Tìm kiếm những chủ thầu không có số phone:
-- SELECT name FROM `contractor` WHERE phone IS NULL

Bài 5: 

-- Thống kê tổng số Kiến trúc sư:
-- SELECT COUNT(name) AS total_architect FROM `architect`;
-- Thống kê tổng số Kiến trúc sư có giới tính là nam:
-- SELECT COUNT(name) AS total_male_architect FROM `architect` WHERE sex = '1';
-- Tìm số ngày tham gia công trình nhiều nhất của mỗi công nhân:
-- SELECT worker_id, MAX(total) AS max_days_worked
FROM work
GROUP BY worker_id;
-- Tìm số ngày tham gia công trình ítnhất của mỗi công nhân:
-- SELECT worker_id, MIN(total) AS min_days_worked
FROM work
GROUP BY worker_id;
-- Tính tổng số ngày tham gia công trình của tất cả công nhân:
-- SELECT SUM(total) AS total_days_worked
FROM work;
-- Tính trung bình số ngày tham gia công trình của tất cả công nhân:
-- SELECT AVG(total) AS average_days_workedFROM work;
-- Hiển thị thông tin họ tên và tuổi của Kiến trúc sư:
-- SELECT name, birthday FROM `architect`
-- Tính thù lao của Kiến trúc sư: Thù lao = benefit * 1000
-- SELECT architect_id, benefit * 1000 AS salary
FROM design;
-- Hiển thị thông tin công trình có chi phí lớn nhất:
SELECT * FROM building WHERE cost = (SELECT MAX(cost) FROM building);
-- Hiển thị thông tin công trình có chi phí lớn nhất được xây dựng ở Cần Thơ:
-- SELECT * FROM building WHERE cost = (SELECT MAX(cost) FROM building WHERE city = 'can tho');
-- Tìm thông tin công trình chưa có Kiến trúc sư thiết kế: 
-- SELECT b.*
FROM building b
LEFT JOIN design d ON b.id = d.building_id
WHERE d.building_id IS NULL;
-- Tìm thông tin Kiến trúc sư có cùng năm sinh và cùng nơi tốt nghiệp:
-- SELECT DISTINCT a.*
FROM architect a
INNER JOIN building b ON a.id = b.contractor_id
WHERE a.birthday IN (
    SELECT birthday
    FROM architect
    GROUP BY birthday
    HAVING COUNT(*) > 1
)
AND a.place IN (
    SELECT place
    FROM architect
    GROUP BY place
    HAVING COUNT(*) > 1
);


Bài 7:

-- Tính thù lao trung bình của mỗi Kiến trúc sư: 
-- SELECT architect.name, AVG(design.benefit) AS average_benefit
FROM architect
LEFT JOIN design ON architect.id = design.architect_id
GROUP BY architect.name;
-- Tính chi phí đầu tư cho các công trình của mỗi thành phố:
-- SELECT city, SUM(cost) AS total_cost
FROM building
GROUP BY city;

-- Tìm các công trình có chi phí trả cho Kiến trúc sư lớn hơn 50:
-- SELECT city, SUM(cost) AS total_investment
FROM building
GROUP BY city
HAVING SUM(cost) > 50;











