-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 07, 2026 at 05:49 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sikawan`
--

-- --------------------------------------------------------

--
-- Table structure for table `asesmens`
--

CREATE TABLE `asesmens` (
  `id` bigint UNSIGNED NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `kompetensi_id` bigint UNSIGNED NOT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `jumlah_soal` int NOT NULL DEFAULT '0',
  `durasi` int NOT NULL DEFAULT '60',
  `nilai_lulus` decimal(5,2) NOT NULL DEFAULT '60.00',
  `acak_soal` tinyint(1) NOT NULL DEFAULT '1',
  `acak_jawaban` tinyint(1) NOT NULL DEFAULT '1',
  `tanggal_mulai` timestamp NULL DEFAULT NULL,
  `tanggal_selesai` timestamp NULL DEFAULT NULL,
  `status` enum('draft','published','ongoing','finished') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asesmen_soals`
--

CREATE TABLE `asesmen_soals` (
  `id` bigint UNSIGNED NOT NULL,
  `asesmen_id` bigint UNSIGNED NOT NULL,
  `bank_soal_id` bigint UNSIGNED NOT NULL,
  `urutan` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

CREATE TABLE `badges` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `nilai_min` decimal(5,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `badges`
--

INSERT INTO `badges` (`id`, `nama`, `icon`, `deskripsi`, `nilai_min`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Data Explorer', NULL, NULL, '0.00', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'Data Analyst', NULL, NULL, '60.00', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'Data Champion', NULL, NULL, '75.00', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'Data Expert', NULL, NULL, '90.00', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bank_soals`
--

CREATE TABLE `bank_soals` (
  `id` bigint UNSIGNED NOT NULL,
  `kompetensi_id` bigint UNSIGNED NOT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `jenis` enum('pilihan_ganda','essay') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pilihan_ganda',
  `pertanyaan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pilihan` json DEFAULT NULL,
  `jawaban_benar` text COLLATE utf8mb4_unicode_ci,
  `pembahasan` text COLLATE utf8mb4_unicode_ci,
  `bobot` decimal(5,2) NOT NULL DEFAULT '1.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bidangs`
--

CREATE TABLE `bidangs` (
  `id` bigint UNSIGNED NOT NULL,
  `opd_id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bidangs`
--

INSERT INTO `bidangs` (`id`, `opd_id`, `nama`, `deskripsi`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Sekretariat', 'Sekretariat Diskominfo', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 1, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Diskominfo', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 1, 'Bidang Layanan Digital', 'Bidang Layanan Digital Diskominfo', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 2, 'Sekretariat', 'Sekretariat Bappeda', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 2, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Bappeda', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(6, 2, 'Bidang Layanan Digital', 'Bidang Layanan Digital Bappeda', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(7, 3, 'Sekretariat', 'Sekretariat BKPSDM', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(8, 3, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik BKPSDM', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(9, 3, 'Bidang Layanan Digital', 'Bidang Layanan Digital BKPSDM', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(10, 4, 'Sekretariat', 'Sekretariat Disdik', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(11, 4, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Disdik', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(12, 4, 'Bidang Layanan Digital', 'Bidang Layanan Digital Disdik', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(13, 5, 'Sekretariat', 'Sekretariat Dinkes', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(14, 5, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Dinkes', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(15, 5, 'Bidang Layanan Digital', 'Bidang Layanan Digital Dinkes', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(16, 6, 'Sekretariat', 'Sekretariat Disdukcapil', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(17, 6, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Disdukcapil', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(18, 6, 'Bidang Layanan Digital', 'Bidang Layanan Digital Disdukcapil', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(19, 7, 'Sekretariat', 'Sekretariat Dinsos', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(20, 7, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Dinsos', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(21, 7, 'Bidang Layanan Digital', 'Bidang Layanan Digital Dinsos', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(22, 8, 'Sekretariat', 'Sekretariat PUPR', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(23, 8, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik PUPR', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(24, 8, 'Bidang Layanan Digital', 'Bidang Layanan Digital PUPR', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(25, 9, 'Sekretariat', 'Sekretariat Dishub', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(26, 9, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Dishub', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(27, 9, 'Bidang Layanan Digital', 'Bidang Layanan Digital Dishub', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(28, 10, 'Sekretariat', 'Sekretariat Satpol PP', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(29, 10, 'Bidang Data dan Statistik', 'Bidang Data dan Statistik Satpol PP', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(30, 10, 'Bidang Layanan Digital', 'Bidang Layanan Digital Satpol PP', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jabatans`
--

CREATE TABLE `jabatans` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `level` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jabatans`
--

INSERT INTO `jabatans` (`id`, `nama`, `deskripsi`, `level`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kepala Dinas', NULL, 1, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'Sekretaris', NULL, 2, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'Kepala Bidang', NULL, 3, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'Analis Data', NULL, 4, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 'Pranata Komputer', NULL, 5, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(6, 'Staff', NULL, 6, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jawaban_pesertas`
--

CREATE TABLE `jawaban_pesertas` (
  `id` bigint UNSIGNED NOT NULL,
  `peserta_asesmen_id` bigint UNSIGNED NOT NULL,
  `bank_soal_id` bigint UNSIGNED NOT NULL,
  `jawaban` text COLLATE utf8mb4_unicode_ci,
  `is_benar` tinyint(1) DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL,
  `catatan_penguji` text COLLATE utf8mb4_unicode_ci,
  `dinilai_oleh` bigint UNSIGNED DEFAULT NULL,
  `dinilai_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategoris`
--

CREATE TABLE `kategoris` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategoris`
--

INSERT INTO `kategoris` (`id`, `nama`, `slug`, `deskripsi`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Dasar', 'dasar', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'Lanjutan', 'lanjutan', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'Sertifikasi', 'sertifikasi', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'Panduan Teknis', 'panduan-teknis', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kompetensis`
--

CREATE TABLE `kompetensis` (
  `id` bigint UNSIGNED NOT NULL,
  `kode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kompetensis`
--

INSERT INTO `kompetensis` (`id`, `kode`, `nama`, `deskripsi`, `domain`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'KMP001', 'Tata Kelola Data', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'KMP002', 'Metadata Statistik', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'KMP003', 'Interoperabilitas Data', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'KMP004', 'Keamanan Informasi', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 'KMP005', 'Analisis Data', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(6, 'KMP006', 'Visualisasi Data', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(7, 'KMP007', 'Kualitas Data', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(8, 'KMP008', 'Integrasi Sistem', NULL, 'Kompetensi Data', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `levels`
--

CREATE TABLE `levels` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` int NOT NULL DEFAULT '0',
  `nilai_min` decimal(5,2) NOT NULL DEFAULT '0.00',
  `nilai_max` decimal(5,2) NOT NULL DEFAULT '100.00',
  `warna` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#000000',
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` (`id`, `nama`, `kode`, `urutan`, `nilai_min`, `nilai_max`, `warna`, `deskripsi`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Pemula', 'pemula', 1, '0.00', '39.00', '#ef4444', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'Dasar', 'dasar', 2, '40.00', '59.00', '#f97316', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'Terampil', 'terampil', 3, '60.00', '74.00', '#eab308', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'Mahir', 'mahir', 4, '75.00', '89.00', '#22c55e', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 'Ahli', 'ahli', 5, '90.00', '100.00', '#3b82f6', NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `materis`
--

CREATE TABLE `materis` (
  `id` bigint UNSIGNED NOT NULL,
  `kompetensi_id` bigint UNSIGNED NOT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `kategori_id` bigint UNSIGNED DEFAULT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `jenis` enum('video','pdf','presentasi','dokumen') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pdf',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durasi` int DEFAULT NULL,
  `urutan` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materi_progress`
--

CREATE TABLE `materi_progress` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `materi_id` bigint UNSIGNED NOT NULL,
  `progress` int NOT NULL DEFAULT '0',
  `is_completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_07_000001_create_opds_table', 1),
(5, '2026_07_07_000002_create_bidangs_table', 1),
(6, '2026_07_07_000003_create_jabatans_table', 1),
(7, '2026_07_07_000004_create_kompetensis_table', 1),
(8, '2026_07_07_000005_create_levels_table', 1),
(9, '2026_07_07_000006_create_badges_table', 1),
(10, '2026_07_07_000007_create_kategoris_table', 1),
(11, '2026_07_07_000008_create_walidatas_table', 1),
(12, '2026_07_07_000009_create_pengujis_table', 1),
(13, '2026_07_07_000010_create_materis_table', 1),
(14, '2026_07_07_000011_create_materi_progress_table', 1),
(15, '2026_07_07_000012_create_bank_soals_table', 1),
(16, '2026_07_07_000013_create_asesmens_table', 1),
(17, '2026_07_07_000014_create_asesmen_soals_table', 1),
(18, '2026_07_07_000015_create_peserta_asesmens_table', 1),
(19, '2026_07_07_000016_create_jawaban_peserta_table', 1),
(20, '2026_07_07_000017_create_nilai_kompetensis_table', 1),
(21, '2026_07_07_000018_create_sertifikats_table', 1),
(22, '2026_07_07_000019_create_audit_logs_table', 1),
(23, '2026_07_07_000020_create_notifikasis_table', 1),
(24, '2026_07_07_000021_create_user_badges_table', 1),
(25, '2026_07_07_030613_create_permission_tables', 1),
(26, '2026_07_07_030613_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 5);

-- --------------------------------------------------------

--
-- Table structure for table `nilai_kompetensis`
--

CREATE TABLE `nilai_kompetensis` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `kompetensi_id` bigint UNSIGNED NOT NULL,
  `asesmen_id` bigint UNSIGNED DEFAULT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `nilai` decimal(5,2) NOT NULL DEFAULT '0.00',
  `kategori` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifikasis`
--

CREATE TABLE `notifikasis` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pesan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `opds`
--

CREATE TABLE `opds` (
  `id` bigint UNSIGNED NOT NULL,
  `kode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `singkatan` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `telepon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opds`
--

INSERT INTO `opds` (`id`, `kode`, `nama`, `singkatan`, `alamat`, `telepon`, `email`, `website`, `logo`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'OPD001', 'Dinas Komunikasi dan Informatika', 'Diskominfo', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(2, 'OPD002', 'Badan Perencanaan Pembangunan Daerah', 'Bappeda', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(3, 'OPD003', 'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia', 'BKPSDM', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(4, 'OPD004', 'Dinas Pendidikan', 'Disdik', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 'OPD005', 'Dinas Kesehatan', 'Dinkes', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(6, 'OPD006', 'Dinas Kependudukan dan Pencatatan Sipil', 'Disdukcapil', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(7, 'OPD007', 'Dinas Sosial', 'Dinsos', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(8, 'OPD008', 'Dinas Pekerjaan Umum dan Penataan Ruang', 'PUPR', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(9, 'OPD009', 'Dinas Perhubungan', 'Dishub', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(10, 'OPD010', 'Satuan Polisi Pamong Praja', 'Satpol PP', NULL, NULL, NULL, NULL, NULL, 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengujis`
--

CREATE TABLE `pengujis` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `nip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bidang_keahlian` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengujis`
--

INSERT INTO `pengujis` (`id`, `user_id`, `nip`, `bidang_keahlian`, `bio`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, '197501012005011001', 'Tata Kelola Data', 'Penguji kompetensi walidata', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(2, 'opd.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(3, 'opd.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(4, 'opd.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(5, 'opd.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(6, 'opd.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(7, 'opd.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(8, 'bidang.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(9, 'bidang.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(10, 'bidang.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(11, 'bidang.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(12, 'bidang.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(13, 'bidang.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(14, 'jabatan.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(15, 'jabatan.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(16, 'jabatan.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(17, 'jabatan.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(18, 'jabatan.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(19, 'jabatan.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(20, 'walidata.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(21, 'walidata.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(22, 'walidata.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(23, 'walidata.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(24, 'walidata.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(25, 'walidata.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(26, 'penguji.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(27, 'penguji.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(28, 'penguji.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(29, 'penguji.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(30, 'penguji.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(31, 'penguji.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(32, 'kompetensi.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(33, 'kompetensi.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(34, 'kompetensi.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(35, 'kompetensi.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(36, 'kompetensi.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(37, 'kompetensi.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(38, 'level.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(39, 'level.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(40, 'level.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(41, 'level.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(42, 'level.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(43, 'level.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(44, 'badge.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(45, 'badge.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(46, 'badge.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(47, 'badge.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(48, 'materi.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(49, 'materi.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(50, 'materi.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(51, 'materi.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(52, 'materi.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(53, 'materi.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(54, 'materi.publish', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(55, 'kategori.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(56, 'kategori.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(57, 'kategori.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(58, 'kategori.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(59, 'pengguna.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(60, 'pengguna.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(61, 'pengguna.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(62, 'pengguna.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(63, 'bank-soal.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(64, 'bank-soal.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(65, 'bank-soal.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(66, 'bank-soal.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(67, 'bank-soal.import', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(68, 'bank-soal.export', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(69, 'quiz.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(70, 'quiz.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(71, 'quiz.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(72, 'quiz.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(73, 'quiz.start', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(74, 'asesmen.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(75, 'asesmen.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(76, 'asesmen.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(77, 'asesmen.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(78, 'asesmen.start', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(79, 'asesmen.grade', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(80, 'asesmen.review', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(81, 'penilaian.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(82, 'penilaian.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(83, 'sertifikat.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(84, 'sertifikat.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(85, 'sertifikat.download', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(86, 'sertifikat.print', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(87, 'monitoring.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(88, 'laporan.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(89, 'laporan.export-pdf', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(90, 'laporan.export-excel', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(91, 'audit-log.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(92, 'notifikasi.view', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(93, 'notifikasi.create', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(94, 'notifikasi.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(95, 'notifikasi.delete', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(96, 'profile.update', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(97, 'password.change', 'web', '2026-07-06 20:02:37', '2026-07-06 20:02:37'),
(98, 'session.manage', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36 Edg/150.0.0.0', 'd65929f4e2793a47777c2d10de4be32b47caa72dfbefdfd919b23d49299034eb', '[\"*\"]', '2026-07-06 21:28:54', NULL, '2026-07-06 20:29:59', '2026-07-06 21:28:54');

-- --------------------------------------------------------

--
-- Table structure for table `peserta_asesmens`
--

CREATE TABLE `peserta_asesmens` (
  `id` bigint UNSIGNED NOT NULL,
  `asesmen_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `waktu_mulai` timestamp NULL DEFAULT NULL,
  `waktu_selesai` timestamp NULL DEFAULT NULL,
  `nilai` decimal(5,2) DEFAULT NULL,
  `status` enum('belum_mulai','sedang_mengerjakan','selesai','dinilai') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'belum_mulai',
  `lulus` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38'),
(2, 'Admin Diskominfo', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38'),
(3, 'Penguji', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38'),
(4, 'Walidata', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38'),
(5, 'Pimpinan', 'web', '2026-07-06 20:02:38', '2026-07-06 20:02:38');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(56, 2),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(61, 2),
(62, 2),
(63, 2),
(64, 2),
(65, 2),
(66, 2),
(67, 2),
(68, 2),
(69, 2),
(70, 2),
(71, 2),
(72, 2),
(73, 2),
(74, 2),
(75, 2),
(76, 2),
(77, 2),
(78, 2),
(79, 2),
(80, 2),
(81, 2),
(82, 2),
(83, 2),
(84, 2),
(85, 2),
(86, 2),
(87, 2),
(88, 2),
(89, 2),
(90, 2),
(92, 2),
(93, 2),
(94, 2),
(95, 2),
(96, 2),
(97, 2),
(98, 2),
(1, 3),
(48, 3),
(63, 3),
(64, 3),
(65, 3),
(66, 3),
(67, 3),
(68, 3),
(74, 3),
(79, 3),
(80, 3),
(81, 3),
(82, 3),
(88, 3),
(96, 3),
(97, 3),
(1, 4),
(48, 4),
(69, 4),
(73, 4),
(74, 4),
(78, 4),
(80, 4),
(83, 4),
(85, 4),
(87, 4),
(92, 4),
(96, 4),
(97, 4),
(1, 5),
(83, 5),
(87, 5),
(88, 5),
(89, 5),
(90, 5),
(91, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sertifikats`
--

CREATE TABLE `sertifikats` (
  `id` bigint UNSIGNED NOT NULL,
  `nomor_sertifikat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `asesmen_id` bigint UNSIGNED DEFAULT NULL,
  `kompetensi_id` bigint UNSIGNED NOT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `nilai_akhir` decimal(5,2) NOT NULL DEFAULT '0.00',
  `kategori_kompetensi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_terbit` date NOT NULL,
  `tanggal_expired` date DEFAULT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Fk9dxM6QLmZK4vQFZslWQlHlaXErRpqZTiL6H10z', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.127.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36', 'eyJfdG9rZW4iOiJGMXhWVDIybTRPZ1prcndyV09qdU41ekdYbUZaQ0t5TXhvYkdiZWFZIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1783397367);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `nip`, `phone`, `address`, `photo`, `email_verified_at`, `password`, `is_active`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'arya', 'aryahulopi12@gmail.com', NULL, '082151665598', NULL, NULL, NULL, '$2y$12$HgXGCpnGZsIfWYDi3lSWPeCh23nyejcpa301eianwc6OmWViNooJC', 1, NULL, '2026-07-06 20:02:38', '2026-07-06 21:28:22', NULL),
(2, 'Admin Diskominfo', 'diskominfo@sikawan.test', NULL, NULL, NULL, NULL, NULL, '$2y$12$HA0FL82FSjpSYwVJVtmZl.N5OmUWS5vdmBRHtaCnNW/nXRsFcx1AK', 1, NULL, '2026-07-06 20:02:38', '2026-07-06 20:02:38', NULL),
(3, 'Penguji', 'penguji@sikawan.test', NULL, NULL, NULL, NULL, NULL, '$2y$12$FeZVxOhx2b11kIDyEJX6Aebhtub2/3gKvZ.y8R2TiFDghfOSKy3PW', 1, NULL, '2026-07-06 20:02:38', '2026-07-06 20:02:38', NULL),
(4, 'Walidata', 'walidata@sikawan.test', NULL, NULL, NULL, NULL, NULL, '$2y$12$yIpEUU3DGvzwWIeI.Xj1/.1fpiPM9g1YBWFmjrbS1of23YH/FENEu', 1, NULL, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL),
(5, 'Pimpinan', 'pimpinan@sikawan.test', NULL, NULL, NULL, NULL, NULL, '$2y$12$1qWivrQBxNBzRgeEOa9oF.rfzk.tjGJviH7HSIrp2rFNrMkGa0sui', 1, NULL, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_badges`
--

CREATE TABLE `user_badges` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `badge_id` bigint UNSIGNED NOT NULL,
  `earned_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `walidatas`
--

CREATE TABLE `walidatas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `opd_id` bigint UNSIGNED NOT NULL,
  `bidang_id` bigint UNSIGNED DEFAULT NULL,
  `jabatan_id` bigint UNSIGNED DEFAULT NULL,
  `level_id` bigint UNSIGNED DEFAULT NULL,
  `nip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nilai_kompetensi` decimal(5,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `walidatas`
--

INSERT INTO `walidatas` (`id`, `user_id`, `opd_id`, `bidang_id`, `jabatan_id`, `level_id`, `nip`, `nilai_kompetensi`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, 1, 1, 4, 1, '198001012010011001', '0.00', 1, '2026-07-06 20:02:39', '2026-07-06 20:02:39', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asesmens`
--
ALTER TABLE `asesmens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asesmens_level_id_foreign` (`level_id`),
  ADD KEY `asesmens_created_by_foreign` (`created_by`),
  ADD KEY `asesmens_status_index` (`status`),
  ADD KEY `asesmens_kompetensi_id_index` (`kompetensi_id`);

--
-- Indexes for table `asesmen_soals`
--
ALTER TABLE `asesmen_soals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asesmen_soals_asesmen_id_bank_soal_id_unique` (`asesmen_id`,`bank_soal_id`),
  ADD KEY `asesmen_soals_bank_soal_id_foreign` (`bank_soal_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_index` (`user_id`),
  ADD KEY `audit_logs_action_index` (`action`),
  ADD KEY `audit_logs_module_index` (`module`),
  ADD KEY `audit_logs_created_at_index` (`created_at`);

--
-- Indexes for table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bank_soals`
--
ALTER TABLE `bank_soals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bank_soals_level_id_foreign` (`level_id`),
  ADD KEY `bank_soals_created_by_foreign` (`created_by`),
  ADD KEY `bank_soals_kompetensi_id_index` (`kompetensi_id`),
  ADD KEY `bank_soals_jenis_index` (`jenis`);

--
-- Indexes for table `bidangs`
--
ALTER TABLE `bidangs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bidangs_opd_id_foreign` (`opd_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `jabatans`
--
ALTER TABLE `jabatans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jawaban_pesertas`
--
ALTER TABLE `jawaban_pesertas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jawaban_pesertas_peserta_asesmen_id_bank_soal_id_unique` (`peserta_asesmen_id`,`bank_soal_id`),
  ADD KEY `jawaban_pesertas_bank_soal_id_foreign` (`bank_soal_id`),
  ADD KEY `jawaban_pesertas_dinilai_oleh_foreign` (`dinilai_oleh`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategoris`
--
ALTER TABLE `kategoris`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kategoris_slug_unique` (`slug`);

--
-- Indexes for table `kompetensis`
--
ALTER TABLE `kompetensis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kompetensis_kode_unique` (`kode`);

--
-- Indexes for table `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `levels_kode_unique` (`kode`);

--
-- Indexes for table `materis`
--
ALTER TABLE `materis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `materis_level_id_foreign` (`level_id`),
  ADD KEY `materis_kategori_id_foreign` (`kategori_id`),
  ADD KEY `materis_created_by_foreign` (`created_by`),
  ADD KEY `materis_kompetensi_id_index` (`kompetensi_id`),
  ADD KEY `materis_is_published_index` (`is_published`);

--
-- Indexes for table `materi_progress`
--
ALTER TABLE `materi_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `materi_progress_user_id_materi_id_unique` (`user_id`,`materi_id`),
  ADD KEY `materi_progress_materi_id_foreign` (`materi_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `nilai_kompetensis`
--
ALTER TABLE `nilai_kompetensis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nilai_kompetensis_kompetensi_id_foreign` (`kompetensi_id`),
  ADD KEY `nilai_kompetensis_asesmen_id_foreign` (`asesmen_id`),
  ADD KEY `nilai_kompetensis_level_id_foreign` (`level_id`),
  ADD KEY `nilai_kompetensis_user_id_kompetensi_id_index` (`user_id`,`kompetensi_id`);

--
-- Indexes for table `notifikasis`
--
ALTER TABLE `notifikasis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifikasis_user_id_is_read_index` (`user_id`,`is_read`);

--
-- Indexes for table `opds`
--
ALTER TABLE `opds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `opds_kode_unique` (`kode`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pengujis`
--
ALTER TABLE `pengujis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pengujis_user_id_foreign` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `peserta_asesmens`
--
ALTER TABLE `peserta_asesmens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `peserta_asesmens_asesmen_id_user_id_unique` (`asesmen_id`,`user_id`),
  ADD KEY `peserta_asesmens_user_id_foreign` (`user_id`),
  ADD KEY `peserta_asesmens_status_index` (`status`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sertifikats`
--
ALTER TABLE `sertifikats`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sertifikats_nomor_sertifikat_unique` (`nomor_sertifikat`),
  ADD KEY `sertifikats_asesmen_id_foreign` (`asesmen_id`),
  ADD KEY `sertifikats_kompetensi_id_foreign` (`kompetensi_id`),
  ADD KEY `sertifikats_level_id_foreign` (`level_id`),
  ADD KEY `sertifikats_user_id_index` (`user_id`),
  ADD KEY `sertifikats_nomor_sertifikat_index` (`nomor_sertifikat`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_nip_unique` (`nip`);

--
-- Indexes for table `user_badges`
--
ALTER TABLE `user_badges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_badges_user_id_badge_id_unique` (`user_id`,`badge_id`),
  ADD KEY `user_badges_badge_id_foreign` (`badge_id`);

--
-- Indexes for table `walidatas`
--
ALTER TABLE `walidatas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `walidatas_user_id_foreign` (`user_id`),
  ADD KEY `walidatas_bidang_id_foreign` (`bidang_id`),
  ADD KEY `walidatas_jabatan_id_foreign` (`jabatan_id`),
  ADD KEY `walidatas_opd_id_index` (`opd_id`),
  ADD KEY `walidatas_level_id_index` (`level_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asesmens`
--
ALTER TABLE `asesmens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asesmen_soals`
--
ALTER TABLE `asesmen_soals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `badges`
--
ALTER TABLE `badges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `bank_soals`
--
ALTER TABLE `bank_soals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bidangs`
--
ALTER TABLE `bidangs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jabatans`
--
ALTER TABLE `jabatans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jawaban_pesertas`
--
ALTER TABLE `jawaban_pesertas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategoris`
--
ALTER TABLE `kategoris`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kompetensis`
--
ALTER TABLE `kompetensis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `levels`
--
ALTER TABLE `levels`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `materis`
--
ALTER TABLE `materis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `materi_progress`
--
ALTER TABLE `materi_progress`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `nilai_kompetensis`
--
ALTER TABLE `nilai_kompetensis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifikasis`
--
ALTER TABLE `notifikasis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `opds`
--
ALTER TABLE `opds`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pengujis`
--
ALTER TABLE `pengujis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `peserta_asesmens`
--
ALTER TABLE `peserta_asesmens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sertifikats`
--
ALTER TABLE `sertifikats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_badges`
--
ALTER TABLE `user_badges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `walidatas`
--
ALTER TABLE `walidatas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asesmens`
--
ALTER TABLE `asesmens`
  ADD CONSTRAINT `asesmens_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `asesmens_kompetensi_id_foreign` FOREIGN KEY (`kompetensi_id`) REFERENCES `kompetensis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `asesmens_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `asesmen_soals`
--
ALTER TABLE `asesmen_soals`
  ADD CONSTRAINT `asesmen_soals_asesmen_id_foreign` FOREIGN KEY (`asesmen_id`) REFERENCES `asesmens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `asesmen_soals_bank_soal_id_foreign` FOREIGN KEY (`bank_soal_id`) REFERENCES `bank_soals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bank_soals`
--
ALTER TABLE `bank_soals`
  ADD CONSTRAINT `bank_soals_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bank_soals_kompetensi_id_foreign` FOREIGN KEY (`kompetensi_id`) REFERENCES `kompetensis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bank_soals_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bidangs`
--
ALTER TABLE `bidangs`
  ADD CONSTRAINT `bidangs_opd_id_foreign` FOREIGN KEY (`opd_id`) REFERENCES `opds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jawaban_pesertas`
--
ALTER TABLE `jawaban_pesertas`
  ADD CONSTRAINT `jawaban_pesertas_bank_soal_id_foreign` FOREIGN KEY (`bank_soal_id`) REFERENCES `bank_soals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `jawaban_pesertas_dinilai_oleh_foreign` FOREIGN KEY (`dinilai_oleh`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `jawaban_pesertas_peserta_asesmen_id_foreign` FOREIGN KEY (`peserta_asesmen_id`) REFERENCES `peserta_asesmens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `materis`
--
ALTER TABLE `materis`
  ADD CONSTRAINT `materis_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `materis_kategori_id_foreign` FOREIGN KEY (`kategori_id`) REFERENCES `kategoris` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `materis_kompetensi_id_foreign` FOREIGN KEY (`kompetensi_id`) REFERENCES `kompetensis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `materis_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `materi_progress`
--
ALTER TABLE `materi_progress`
  ADD CONSTRAINT `materi_progress_materi_id_foreign` FOREIGN KEY (`materi_id`) REFERENCES `materis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `materi_progress_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nilai_kompetensis`
--
ALTER TABLE `nilai_kompetensis`
  ADD CONSTRAINT `nilai_kompetensis_asesmen_id_foreign` FOREIGN KEY (`asesmen_id`) REFERENCES `asesmens` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `nilai_kompetensis_kompetensi_id_foreign` FOREIGN KEY (`kompetensi_id`) REFERENCES `kompetensis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `nilai_kompetensis_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `nilai_kompetensis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifikasis`
--
ALTER TABLE `notifikasis`
  ADD CONSTRAINT `notifikasis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pengujis`
--
ALTER TABLE `pengujis`
  ADD CONSTRAINT `pengujis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `peserta_asesmens`
--
ALTER TABLE `peserta_asesmens`
  ADD CONSTRAINT `peserta_asesmens_asesmen_id_foreign` FOREIGN KEY (`asesmen_id`) REFERENCES `asesmens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `peserta_asesmens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sertifikats`
--
ALTER TABLE `sertifikats`
  ADD CONSTRAINT `sertifikats_asesmen_id_foreign` FOREIGN KEY (`asesmen_id`) REFERENCES `asesmens` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sertifikats_kompetensi_id_foreign` FOREIGN KEY (`kompetensi_id`) REFERENCES `kompetensis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sertifikats_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sertifikats_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_badges`
--
ALTER TABLE `user_badges`
  ADD CONSTRAINT `user_badges_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_badges_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `walidatas`
--
ALTER TABLE `walidatas`
  ADD CONSTRAINT `walidatas_bidang_id_foreign` FOREIGN KEY (`bidang_id`) REFERENCES `bidangs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `walidatas_jabatan_id_foreign` FOREIGN KEY (`jabatan_id`) REFERENCES `jabatans` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `walidatas_level_id_foreign` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `walidatas_opd_id_foreign` FOREIGN KEY (`opd_id`) REFERENCES `opds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `walidatas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
