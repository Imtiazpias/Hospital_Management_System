-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 14, 2025 at 06:06 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospitalDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`admin_id`, `username`, `password`, `full_name`, `email`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', '1234', 'Sourav Halder', 'halder23105101502@diu.edu.bd', NULL, '2025-04-13 21:00:35', '2025-04-13 21:00:35');

-- --------------------------------------------------------

--
-- Table structure for table `Appointments`
--

CREATE TABLE `Appointments` (
  `appointment_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `reason` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('scheduled','completed','cancelled','no_show') DEFAULT 'scheduled',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Appointments`
--

INSERT INTO `Appointments` (`appointment_id`, `doctor_id`, `patient_id`, `appointment_date`, `appointment_time`, `reason`, `description`, `status`, `created_at`) VALUES
(1, 1, 1, '2025-04-20', '10:00:00', 'Chest Pain', 'Consultation for persistent chest pain', 'scheduled', '2025-04-15 04:00:00'),
(2, 2, 2, '2025-04-21', '11:30:00', 'Headache', 'Recurring headache and dizziness', 'scheduled', '2025-04-16 05:00:00'),
(3, 3, 3, '2025-04-22', '09:00:00', 'Back Pain', 'Severe back pain affecting mobility', 'scheduled', '2025-04-17 03:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `Billing`
--

CREATE TABLE `Billing` (
  `bill_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `bill_date` date NOT NULL,
  `amount_due` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT 0.00,
  `total_amount` decimal(10,2) GENERATED ALWAYS AS (`amount_due` - `discount`) STORED,
  `payment_status` enum('paid','unpaid','partial') DEFAULT 'unpaid',
  `payment_method` enum('cash','card','insurance','online') DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Billing`
--

INSERT INTO `Billing` (`bill_id`, `patient_id`, `bill_date`, `amount_due`, `discount`, `payment_status`, `payment_method`, `transaction_id`, `notes`) VALUES
(1, 1, '2025-04-20', 5000.00, 500.00, 'paid', 'cash', 'TXN12345', 'Paid in full'),
(2, 2, '2025-04-21', 3000.00, 300.00, 'paid', 'card', 'TXN12346', 'Paid with credit card'),
(3, 3, '2025-04-22', 2000.00, 0.00, 'unpaid', NULL, NULL, 'Pending payment');

-- --------------------------------------------------------

--
-- Table structure for table `Departments`
--

CREATE TABLE `Departments` (
  `dept_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Departments`
--

INSERT INTO `Departments` (`dept_id`, `name`, `description`, `status`) VALUES
(1, 'Cardiology', 'Focuses on the treatment of heart diseases', 'active'),
(2, 'Neurology', 'Deals with disorders of the nervous system', 'active'),
(3, 'Orthopedics', 'Handles bone and muscle-related treatments', 'active'),
(4, 'Pediatrics', 'Provides medical care for children', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `Doctors`
--

CREATE TABLE `Doctors` (
  `doctor_id` int(11) NOT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `qualification` varchar(100) NOT NULL,
  `contact_info` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `availability` varchar(50) DEFAULT NULL,
  `joining_date` date NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Doctors`
--

INSERT INTO `Doctors` (`doctor_id`, `dept_id`, `first_name`, `last_name`, `qualification`, `contact_info`, `email`, `address`, `availability`, `joining_date`, `status`) VALUES
(1, 1, 'Farhan', 'Ali', 'MBBS, FCPS (Cardiology)', '+8801740012345', 'farhan.ali@hospitalbd.com', 'Dhaka, Bangladesh', 'Mon-Fri: 9 AM - 2 PM', '2023-06-15', 'active'),
(2, 2, 'Nusrat', 'Jahan', 'MBBS, MD (Neurology)', '+8801680012345', 'nusrat.jahan@hospitalbd.com', 'Chattogram, Bangladesh', 'Tue-Thu: 10 AM - 3 PM', '2023-07-01', 'active'),
(3, 3, 'Sayed', 'Hasan', 'MBBS, MS (Orthopedics)', '+8801721012345', 'sayed.hasan@hospitalbd.com', 'Sylhet, Bangladesh', 'Mon-Fri: 8 AM - 12 PM', '2023-08-10', 'active'),
(4, 4, 'Tahmina', 'Rahman', 'MBBS, FCPS (Pediatrics)', '+8801760012345', 'tahmina.rahman@hospitalbd.com', 'Barisal, Bangladesh', 'Sat-Mon: 11 AM - 4 PM', '2023-09-20', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `MedicalRecords`
--

CREATE TABLE `MedicalRecords` (
  `record_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `visit_date` date NOT NULL,
  `diagnosis` varchar(255) NOT NULL,
  `prescribed_medication` varchar(255) DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `MedicalRecords`
--

INSERT INTO `MedicalRecords` (`record_id`, `patient_id`, `doctor_id`, `appointment_id`, `visit_date`, `diagnosis`, `prescribed_medication`, `treatment`, `notes`) VALUES
(1, 1, 1, 1, '2025-04-20', 'Angina', 'Nitroglycerin, Aspirin', 'Lifestyle changes and medication', 'Monitor heart activity'),
(2, 2, 2, 2, '2025-04-21', 'Migraine', 'Paracetamol, Sumatriptan', 'Regular medication and diet change', 'Follow-up in one month'),
(3, 3, 3, 3, '2025-04-22', 'Lumbar Strain', 'Ibuprofen', 'Physiotherapy', 'Reduce physical strain');

-- --------------------------------------------------------

--
-- Table structure for table `Patients`
--

CREATE TABLE `Patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `blood_group` enum('A+','A-','B+','B-','AB+','AB-','O+','O-','Unknown') DEFAULT NULL,
  `contact_info` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Patients`
--

INSERT INTO `Patients` (`patient_id`, `first_name`, `last_name`, `dob`, `gender`, `blood_group`, `contact_info`, `email`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Ariful', 'Islam', '1995-04-15', 'Male', 'O+', '+8801712345678', 'ariful.islam@gmail.com', 'Dhaka, Bangladesh', '2025-04-01 06:00:00', '2025-04-01 06:00:00'),
(2, 'Sadia', 'Afroz', '2001-07-22', 'Female', 'A+', '+8801612345678', 'sadia.afroz@gmail.com', 'Sylhet, Bangladesh', '2025-04-05 09:00:00', '2025-04-05 09:00:00'),
(3, 'Mizanur', 'Rahman', '1988-01-30', 'Male', 'B-', '+8801512345678', 'mizanur.rahman@gmail.com', 'Khulna, Bangladesh', '2025-04-10 04:00:00', '2025-04-10 04:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `Appointments`
--
ALTER TABLE `Appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `Billing`
--
ALTER TABLE `Billing`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `Departments`
--
ALTER TABLE `Departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `Doctors`
--
ALTER TABLE `Doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `MedicalRecords`
--
ALTER TABLE `MedicalRecords`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `Patients`
--
ALTER TABLE `Patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Appointments`
--
ALTER TABLE `Appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Billing`
--
ALTER TABLE `Billing`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Departments`
--
ALTER TABLE `Departments`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Doctors`
--
ALTER TABLE `Doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `MedicalRecords`
--
ALTER TABLE `MedicalRecords`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Patients`
--
ALTER TABLE `Patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Appointments`
--
ALTER TABLE `Appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `Doctors` (`doctor_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`patient_id`) ON DELETE CASCADE;

--
-- Constraints for table `Billing`
--
ALTER TABLE `Billing`
  ADD CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`patient_id`) ON DELETE CASCADE;

--
-- Constraints for table `Doctors`
--
ALTER TABLE `Doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Departments` (`dept_id`);

--
-- Constraints for table `MedicalRecords`
--
ALTER TABLE `MedicalRecords`
  ADD CONSTRAINT `medicalrecords_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `Patients` (`patient_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicalrecords_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `Doctors` (`doctor_id`),
  ADD CONSTRAINT `medicalrecords_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `Appointments` (`appointment_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
