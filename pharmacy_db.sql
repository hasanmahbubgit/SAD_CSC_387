-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2026 at 10:51 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmacy_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `address`, `created_at`) VALUES
(1, 'Tanzim Hasan', '01700000000', 'Uttara, Dhaka', '2026-05-08 19:54:04'),
(2, 'Md Parvez Khandaker', '01800000000', 'Gazipur, Dhaka', '2026-05-08 19:54:59'),
(3, 'Mahbub Hasan', '01601327842', 'uttara, Dhaka', '2026-05-23 08:16:43'),
(4, 'Shaiful Islam', '01532394993', 'Gazipur, Dhaka', '2026-05-23 08:18:12'),
(5, 'Jahidul Islam', '01738392449', 'Mohakhali, Dhaka', '2026-05-23 08:18:54');

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `generic_name` varchar(150) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock_qty` int(11) NOT NULL DEFAULT 0,
  `min_threshold` int(11) NOT NULL DEFAULT 10,
  `expiry_date` date DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`id`, `name`, `generic_name`, `category`, `unit_price`, `stock_qty`, `min_threshold`, `expiry_date`, `supplier_id`, `created_at`) VALUES
(3, 'Azithro 500mg', 'Azithromycin', 'Antibiotic', 45.00, 28, 10, '2025-09-30', 1, '2026-05-08 10:12:10'),
(4, 'Amlodipine 5mg', 'Amlodipine', 'Cardiac', 18.00, 12, 10, '2026-03-31', 2, '2026-05-08 10:12:10'),
(7, 'MaxPro', 'Prazole', '', 6.00, 30, 10, '2026-05-30', NULL, '2026-05-09 10:08:09'),
(8, 'Napa 500mg', 'Paracetamol', 'Analgesic', 5.00, 500, 50, '2027-12-31', NULL, '2026-05-23 07:11:00'),
(9, 'Seclo 20mg', 'Omeprazole', 'Antacid', 8.00, 8, 20, '2026-11-30', NULL, '2026-05-23 07:11:00'),
(10, 'Azimax 500mg', 'Azithromycin', 'Antibiotic', 45.00, 150, 20, '2026-09-30', NULL, '2026-05-23 07:11:00'),
(11, 'Metformin 500mg', 'Metformin HCl', 'Antidiabetic', 6.00, 3, 30, '2027-06-30', NULL, '2026-05-23 07:11:00'),
(12, 'Losartan 50mg', 'Losartan Potassium', 'Antihypertensive', 12.00, 195, 25, '2027-03-31', NULL, '2026-05-23 07:11:00'),
(13, 'Cetirizine 10mg', 'Cetirizine HCl', 'Antihistamine', 4.00, 0, 20, '2025-01-01', NULL, '2026-05-23 07:11:00'),
(14, 'Amoxicillin 500mg', 'Amoxicillin', 'Antibiotic', 15.00, 180, 30, '2026-08-31', NULL, '2026-05-23 07:11:00'),
(15, 'Atorvastatin 20mg', 'Atorvastatin', 'Cholesterol', 22.00, 17, 10, '2026-05-22', NULL, '2026-05-23 07:11:00'),
(16, 'Neoton 10mg', 'Domperidone', 'Antiemetic', 7.00, 12, 25, '2026-10-31', NULL, '2026-05-23 07:11:00'),
(17, 'Fexo 120mg', 'Fexofenadine', 'Antihistamine', 18.00, 75, 15, '2027-01-31', NULL, '2026-05-23 07:11:00'),
(18, 'Revive Hair Fall Fight Shampoo 200ml', 'Fruit Extract & Milk', 'Hair Care', 230.00, 40, 10, '2027-12-31', NULL, '2026-05-23 07:13:01'),
(19, 'Revive Enhancing & Repair Shampoo 200ml', 'Milk & Fruit Extract', 'Hair Care', 220.00, 34, 10, '2027-11-30', NULL, '2026-05-23 07:13:01'),
(20, 'SkinCafe Soothing Aloe Vera Facewash 100ml', 'Aloe Vera Extract', 'Skin Care', 280.00, 25, 5, '2027-10-31', NULL, '2026-05-23 07:13:01'),
(21, 'SkinCafe Herbal Hair Oil 100ml', 'Herbal Extract', 'Hair Care', 320.00, 20, 5, '2027-09-30', NULL, '2026-05-23 07:13:01'),
(22, 'SkinCafe Natural Moisturizer 50ml', 'Natural Botanical Extract', 'Skin Care', 350.00, 18, 5, '2027-08-31', NULL, '2026-05-23 07:13:01'),
(23, 'Neutrogena Ultra Sheer Sunscreen SPF50 50ml (USA)', 'Homosalate', 'Skin Care', 750.00, 15, 5, '2027-06-30', NULL, '2026-05-23 07:13:01'),
(24, 'La Roche-Posay Sunscreen SPF50 50ml (France)', 'Mexoryl SX', 'Skin Care', 1200.00, 10, 3, '2027-07-31', NULL, '2026-05-23 07:13:01'),
(25, 'Ace 500mg', 'Paracetamol', 'Analgesic', 5.00, 300, 30, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(26, 'Ibuprofen 400mg', 'Ibuprofen', 'Analgesic', 8.00, 200, 25, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(27, 'Naproxen 500mg', 'Naproxen Sodium', 'Analgesic', 12.00, 145, 20, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(28, 'Diclofenac 50mg', 'Diclofenac Sodium', 'Analgesic', 10.00, 180, 20, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(29, 'Tramadol 50mg', 'Tramadol HCl', 'Analgesic', 15.00, 100, 15, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(30, 'Azithromycin 250mg', 'Azithromycin', 'Antibiotic', 35.00, 120, 20, '2027-07-31', NULL, '2026-05-23 08:15:49'),
(31, 'Ciprofloxacin 500mg', 'Ciprofloxacin HCl', 'Antibiotic', 18.00, 160, 20, '2027-06-30', NULL, '2026-05-23 08:15:49'),
(32, 'Doxycycline 100mg', 'Doxycycline HCl', 'Antibiotic', 12.00, 140, 20, '2027-05-31', NULL, '2026-05-23 08:15:49'),
(33, 'Metronidazole 400mg', 'Metronidazole', 'Antibiotic', 6.00, 200, 25, '2027-04-30', NULL, '2026-05-23 08:15:49'),
(34, 'Cloxacillin 500mg', 'Cloxacillin Sodium', 'Antibiotic', 20.00, 90, 15, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(35, 'Cefuroxime 250mg', 'Cefuroxime Axetil', 'Antibiotic', 55.00, 80, 15, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(36, 'Flucloxacillin 500mg', 'Flucloxacillin', 'Antibiotic', 25.00, 70, 10, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(37, 'Pantoprazole 40mg', 'Pantoprazole Sodium', 'Antacid', 10.00, 235, 30, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(38, 'Ranitidine 150mg', 'Ranitidine HCl', 'Antacid', 5.00, 300, 30, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(39, 'Domperidone 10mg', 'Domperidone', 'Antiemetic', 6.00, 220, 25, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(40, 'Ondansetron 4mg', 'Ondansetron HCl', 'Antiemetic', 18.00, 145, 20, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(41, 'Loperamide 2mg', 'Loperamide HCl', 'Antidiarrheal', 8.00, 180, 20, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(42, 'Bismuth 262mg', 'Bismuth Subsalicylate', 'Antacid', 15.00, 100, 15, '2027-07-31', NULL, '2026-05-23 08:15:49'),
(43, 'Glibenclamide 5mg', 'Glibenclamide', 'Antidiabetic', 5.00, 200, 25, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(44, 'Sitagliptin 100mg', 'Sitagliptin Phosphate', 'Antidiabetic', 85.00, 60, 10, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(45, 'Glimepiride 2mg', 'Glimepiride', 'Antidiabetic', 12.00, 150, 20, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(46, 'Amlodipine 10mg', 'Amlodipine Besylate', 'Cardiac', 15.00, 180, 20, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(47, 'Atenolol 50mg', 'Atenolol', 'Cardiac', 8.00, 200, 25, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(48, 'Enalapril 5mg', 'Enalapril Maleate', 'Cardiac', 10.00, 160, 20, '2027-07-31', NULL, '2026-05-23 08:15:49'),
(49, 'Valsartan 80mg', 'Valsartan', 'Cardiac', 22.00, 120, 15, '2027-06-30', NULL, '2026-05-23 08:15:49'),
(50, 'Carvedilol 6.25mg', 'Carvedilol', 'Cardiac', 18.00, 100, 15, '2027-05-31', NULL, '2026-05-23 08:15:49'),
(51, 'Montelukast 10mg', 'Montelukast Sodium', 'Respiratory', 25.00, 140, 20, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(52, 'Salbutamol 2mg', 'Salbutamol Sulfate', 'Respiratory', 5.00, 250, 30, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(53, 'Loratadine 10mg', 'Loratadine', 'Antihistamine', 8.00, 200, 25, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(54, 'Chlorpheniramine 4mg', 'Chlorpheniramine Maleate', 'Antihistamine', 4.00, 300, 30, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(55, 'Vitamin C 500mg', 'Ascorbic Acid', 'Vitamin', 6.00, 400, 40, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(56, 'Vitamin D3 1000IU', 'Cholecalciferol', 'Vitamin', 15.00, 190, 25, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(57, 'Calcium + D3 500mg', 'Calcium Carbonate', 'Vitamin', 12.00, 180, 20, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(58, 'Zinc 20mg', 'Zinc Sulfate', 'Vitamin', 8.00, 220, 25, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(59, 'B-Complex Tablet', 'Vitamin B Complex', 'Vitamin', 10.00, 300, 30, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(60, 'Iron 65mg', 'Ferrous Sulfate', 'Vitamin', 7.00, 250, 25, '2027-07-31', NULL, '2026-05-23 08:15:49'),
(61, 'Clotrimazole Cream 20g', 'Clotrimazole', 'Dermatology', 35.00, 80, 10, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(62, 'Betamethasone Cream 15g', 'Betamethasone Valerate', 'Dermatology', 40.00, 70, 10, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(63, 'Permethrin Cream 30g', 'Permethrin', 'Dermatology', 55.00, 50, 8, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(64, 'Salicylic Acid 6% 50g', 'Salicylic Acid', 'Dermatology', 45.00, 60, 8, '2027-09-30', NULL, '2026-05-23 08:15:49'),
(65, 'Ciprofloxacin Eye Drop 5ml', 'Ciprofloxacin', 'Eye Care', 45.00, 60, 10, '2027-08-31', NULL, '2026-05-23 08:15:49'),
(66, 'Chloramphenicol Eye Drop 5ml', 'Chloramphenicol', 'Eye Care', 35.00, 70, 10, '2027-07-31', NULL, '2026-05-23 08:15:49'),
(67, 'Xylometazoline Nasal Drop', 'Xylometazoline HCl', 'ENT', 30.00, 80, 10, '2027-06-30', NULL, '2026-05-23 08:15:49'),
(68, 'Otosporin Ear Drop 5ml', 'Polymyxin B', 'ENT', 65.00, 50, 8, '2027-05-31', NULL, '2026-05-23 08:15:49'),
(69, 'Diazepam 5mg', 'Diazepam', 'Neurological', 8.00, 100, 15, '2027-12-31', NULL, '2026-05-23 08:15:49'),
(70, 'Amitriptyline 25mg', 'Amitriptyline HCl', 'Neurological', 6.00, 120, 15, '2027-11-30', NULL, '2026-05-23 08:15:49'),
(71, 'Gabapentin 300mg', 'Gabapentin', 'Neurological', 25.00, 80, 10, '2027-10-31', NULL, '2026-05-23 08:15:49'),
(72, 'Ceftriaxone 1g Injection', 'Ceftriaxone Sodium', 'Antibiotic', 120.00, 30, 5, '2026-06-02', NULL, '2026-05-23 08:15:49'),
(73, 'Hydrocortisone 10mg', 'Hydrocortisone', 'Steroid', 18.00, 25, 5, '2026-06-12', NULL, '2026-05-23 08:15:49'),
(74, 'Erythromycin 250mg', 'Erythromycin Stearate', 'Antibiotic', 15.00, 40, 8, '2026-06-20', NULL, '2026-05-23 08:15:49');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL,
  `pharmacist_id` int(11) DEFAULT NULL,
  `patient_name` varchar(100) NOT NULL,
  `doctor_name` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `pharmacist_id`, `patient_name`, `doctor_name`, `notes`, `created_at`) VALUES
(1, 1, 'Rashed', 'Dr Ibrahim', 'Napa .5mg (1+0+1)  \r\nSeclo .5mg (0+0+1)', '2026-05-08 20:31:29'),
(2, 2, 'Md. Mahbub Hasan', 'Dr. Umar Bin Khattab', '1. Napa 500 mg (1+0+1) - 3 days\r\n2. Tab Endeavour 10 mg (1+0+1) - 7 days\r\n3. Tab Revotrill 25mg (0+0+1) - 7 days', '2026-05-23 08:33:50');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `medicine_id` int(11) DEFAULT NULL,
  `qty_ordered` int(11) NOT NULL,
  `unit_cost` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','received') DEFAULT 'pending',
  `ordered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `cashier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_name` varchar(100) DEFAULT 'Walk-in',
  `payment_method` enum('cash','card','bkash','nagad') DEFAULT 'cash',
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `cashier_id`, `customer_id`, `customer_name`, `payment_method`, `total_amount`, `discount`, `created_at`) VALUES
(1, 1, 1, '', 'bkash', 45.00, 0.00, '2026-05-08 20:05:36'),
(2, 1, 1, '', 'bkash', 35.00, 10.00, '2026-05-08 20:06:30'),
(3, 1, 2, '', 'cash', 26.00, 10.00, '2026-05-08 20:11:26'),
(4, 1, 2, 'Parvez', 'nagad', 15.00, 0.00, '2026-05-08 20:12:16'),
(5, 1, NULL, 'Mr. Easin', 'cash', 17.50, 5.00, '2026-05-09 06:28:05'),
(6, 1, 2, '', 'card', 162.00, 0.00, '2026-05-22 18:44:24'),
(7, 1, 2, '', 'card', 162.00, 0.00, '2026-05-22 18:44:31'),
(8, 1, NULL, 'mahbub', 'cash', 63.00, 0.00, '2026-05-22 18:47:29'),
(9, 1, 3, '', 'cash', 55.00, 5.00, '2026-05-23 08:26:12'),
(10, 2, NULL, '', 'card', 60.00, 0.00, '2026-05-23 08:34:34'),
(11, 2, NULL, 'mahbub', 'card', 370.00, 0.00, '2026-05-23 08:43:13'),
(12, 2, 4, '', 'bkash', 90.00, 0.00, '2026-05-23 08:45:30'),
(13, 3, 5, '', 'cash', 140.00, 10.00, '2026-05-23 08:48:41');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `medicine_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `medicine_id`, `qty`, `unit_price`, `subtotal`) VALUES
(1, 1, 3, 1, 45.00, 45.00),
(2, 2, 3, 1, 45.00, 45.00),
(6, 6, 4, 9, 18.00, 162.00),
(7, 7, 4, 9, 18.00, 162.00),
(9, 9, 27, 5, 12.00, 60.00),
(10, 10, 12, 5, 12.00, 60.00),
(11, 11, 19, 1, 220.00, 220.00),
(12, 11, 56, 10, 15.00, 150.00),
(13, 12, 40, 5, 18.00, 90.00),
(14, 13, 37, 15, 10.00, 150.00);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `contact_person` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `email`, `address`, `contact_person`) VALUES
(1, 'Square Pharma', '01700000001', 'easin@square.com', 'Turag, Dhaka, Bangladesh', 'Md. Easin'),
(2, 'Beximco Pharma', '01700000002', 'farid@beximco.com', 'Turag, Uttara, Dhaka', 'Farid Hosen'),
(3, 'ACI Limited', '01711-234567', 'kamal.sales@aci-bd.com', 'ACI Centre, 245 Tejgaon, Dhaka', 'Mr. Kamal Hossain'),
(4, 'Opsonin Pharma', '01711-345678', 'sales@opsonin.com', 'Opsonin House, Motijheel, Dhaka', 'Mr. Rahim Uddin'),
(5, 'Incepta Pharmaceuticals', '01711-456789', 'sales@incepta.com', 'Zirabo, Ashulia, Savar, Dhaka', 'Mr. Nasir Ahmed'),
(6, 'Renata Limited', '01711-567890', 'sales@renata.com', 'Mirpur Road, Dhaka', 'Mr. Faruk Islam'),
(7, 'Aristopharma', '01711-678901', 'shahid.sales@aristopharma.com', 'Tejgaon Industrial Area, Dhaka', 'Mr. Shahid Khan'),
(8, 'Drug International', '01711-789012', 'tariq.sales@druginternational.com', 'Rupganj, Narayanganj', 'Mr. Tariq Hassan'),
(9, 'Healthcare Pharmaceuticals', '01711-890123', 'sales@healthcare-bd.com', 'Tongi Industrial Area, Gazipur', 'Mr. Jamil Ahmed'),
(10, 'General Pharmaceuticals', '01711-901234', 'anwar.sales@generalpharma.com', 'Tejgaon, Dhaka', 'Mr. Anwar Hossain'),
(11, 'Pfizer Inc (USA)', '01711-112233', 'bd@pfizer.com', 'Gulshan 2, Dhaka', 'Mr. David Smith'),
(12, 'Novartis (Switzerland)', '01711-223344', 'bd@novartis.com', 'Banani, Dhaka', 'Mr. Hans Mueller'),
(13, 'Roche (Switzerland)', '01711-334455', 'bd@roche.com', 'Uttara, Dhaka', 'Mr. Peter Lang'),
(14, 'Johnson & Johnson (USA)', '01711-445566', 'bd@jnj.com', 'Gulshan 1, Dhaka', 'Mr. James Brown'),
(15, 'Unilever Bangladesh', '01711-556677', 'bd@unilever.com', 'Tejgaon, Dhaka', 'Mr. Tanvir Ahmed');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','pharmacist','cashier','inventory') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Admin', 'admin@pharmacy.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '2026-05-08 10:12:10'),
(2, 'Fares', 'Fares@pharmacy.com', '$2y$10$TutWYipjst23F5Ad7SIlDO7V91lwye24qEb24gTbjq5whnfjgYVaa', 'pharmacist', '2026-05-08 10:12:10'),
(3, 'Karim', 'karim@pharmacy.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'cashier', '2026-05-08 10:12:10'),
(6, 'Hasan', 'hasan@pharmacy.com', '$2y$10$.hhEEq0gHFgM71JGJYQRguH5kr/s1A4iLbJOKvud5jb3pfozgZ3dy', 'inventory', '2026-05-23 07:20:53');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pharmacist_id` (`pharmacist_id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `medicine_id` (`medicine_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cashier_id` (`cashier_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `medicine_id` (`medicine_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `medicines_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`pharmacist_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `sale_items_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sale_items_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
