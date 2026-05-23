<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}
require_once 'config/db.php';

$role = $_SESSION['role'];

// ── Stats (fetched per role) ──────────────────────────────────────────────────
$total_medicines     = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM medicines"))['total'];
$total_customers     = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM customers"))['total'];
$total_suppliers     = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM suppliers"))['total'];
$total_prescriptions = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM prescriptions"))['total'];
$total_sales         = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM sales"))['total'];
$low_stock_count     = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM medicines WHERE stock_qty <= min_threshold"))['total'];
$expired_count       = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM medicines WHERE expiry_date < CURDATE()"))['total'];
$expiring_soon_count = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM medicines WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)"))['total'];

$today_sales = mysqli_fetch_assoc(mysqli_query($conn, "SELECT SUM(total_amount) as total FROM sales WHERE DATE(created_at) = CURDATE()"))['total'];
$today_sales = $today_sales ? $today_sales : 0;

$low_stock    = mysqli_query($conn, "SELECT * FROM medicines WHERE stock_qty <= min_threshold ORDER BY stock_qty ASC LIMIT 5");
$expired      = mysqli_query($conn, "SELECT * FROM medicines WHERE expiry_date < CURDATE() LIMIT 5");
$recent_sales = mysqli_query($conn, "SELECT s.*, u.name as cashier_name FROM sales s JOIN users u ON s.cashier_id = u.id ORDER BY s.created_at DESC LIMIT 5");

// ── Role-based page titles ────────────────────────────────────────────────────
$page_titles = [
    'admin'       => '⚙️ Admin Dashboard',
    'pharmacist'  => '💊 Pharmacist Dashboard',
    'cashier'     => '🛒 Cashier Dashboard',
    'inventory'   => '📦 Inventory Dashboard',
];
$page_title = $page_titles[$role] ?? 'Dashboard';

// ── Sidebar colors per role ───────────────────────────────────────────────────
$sidebar_colors = [
    'admin'      => '#2c3e50',
    'pharmacist' => '#1a5276',
    'cashier'    => '#145a32',
    'inventory'  => '#6e2f8c',
];
$sidebar_color = $sidebar_colors[$role] ?? '#2c3e50';
?>
<!DOCTYPE html>
<html>
<head>
    <title><?= $page_title ?> - Satota Pharmacy & Departmental Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .sidebar {
            min-height: 100vh;
            background: <?= $sidebar_color ?>;
            padding-top: 20px;
        }
        .sidebar a {
            color: #ecf0f1;
            display: block;
            padding: 12px 20px;
            text-decoration: none;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            transition: background 0.2s;
        }
        .sidebar a:hover { background: rgba(255,255,255,0.1); }
        .sidebar .brand {
            color: white;
            font-size: 15px;
            font-weight: bold;
            padding: 10px 20px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .role-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 8px;
        }
        .badge-admin      { background:#e74c3c; color:white; }
        .badge-pharmacist { background:#2980b9; color:white; }
        .badge-cashier    { background:#27ae60; color:white; }
        .badge-inventory  { background:#8e44ad; color:white; }
        .stat-card { border-radius: 10px; padding: 20px; color: white; margin-bottom: 20px; }
        .main-content { padding: 20px; }
    </style>
</head>
<body>
<div class="container-fluid">
<div class="row">

<!-- ── SIDEBAR ─────────────────────────────────────────────────────────────── -->
<div class="col-md-2 sidebar p-0">
    <div class="brand">🏥 Satota Pharmacy & Departmental Store</div>

    <a href="dashboard.php">📊 Dashboard</a>

    <?php if (in_array($role, ['admin', 'pharmacist', 'inventory'])): ?>
    <a href="medicines/list.php">💊 Medicines</a>
    <?php endif; ?>

    <?php if (in_array($role, ['admin', 'pharmacist'])): ?>
    <a href="customers/list.php">👥 Customers</a>
    <?php endif; ?>

    <?php if (in_array($role, ['admin', 'inventory'])): ?>
    <a href="suppliers/list.php">🚚 Suppliers</a>
    <?php endif; ?>

    <?php if (in_array($role, ['admin', 'pharmacist', 'cashier'])): ?>
    <a href="sales/create.php">🛒 New Sale</a>
    <a href="sales/list.php">📋 Sales History</a>
    <?php endif; ?>

    <?php if (in_array($role, ['admin', 'pharmacist'])): ?>
    <a href="prescriptions/list.php">📝 Prescriptions</a>
    <?php endif; ?>

    <?php if (in_array($role, ['admin'])): ?>
    <a href="reports/index.php">📈 Reports</a>
    <a href="users/list.php">👤 Users</a>
    <?php endif; ?>

    <a href="logout.php" style="color:#e74c3c; margin-top:20px;">🚪 Logout</a>
</div>

<!-- ── MAIN CONTENT ────────────────────────────────────────────────────────── -->
<div class="col-md-10 main-content">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4><?= $page_title ?></h4>
        <span>
            Welcome, <strong><?= $_SESSION['user_name'] ?></strong>
            <span class="role-badge badge-<?= $role ?>"><?= strtoupper($role) ?></span>
        </span>
    </div>

    <!-- ── ADMIN DASHBOARD ──────────────────────────────────────────────────── -->
    <?php if ($role == 'admin'): ?>

    <div class="row">
        <div class="col-md-3"><div class="stat-card" style="background:#2ecc71;">
            <h6>Today's Sales</h6><h3>৳<?= number_format($today_sales, 2) ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#3498db;">
            <h6>Total Medicines</h6><h3><?= $total_medicines ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#9b59b6;">
            <h6>Total Customers</h6><h3><?= $total_customers ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#e67e22;">
            <h6>Total Sales</h6><h3><?= $total_sales ?></h3>
        </div></div>
    </div>
    <div class="row">
        <div class="col-md-3"><div class="stat-card" style="background:#1abc9c;">
            <h6>Total Suppliers</h6><h3><?= $total_suppliers ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#e74c3c;">
            <h6>Expired Medicines</h6><h3><?= $expired_count ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#f39c12;">
            <h6>Low Stock Items</h6><h3><?= $low_stock_count ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#2980b9;">
            <h6>Total Prescriptions</h6><h3><?= $total_prescriptions ?></h3>
        </div></div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="card border-warning mb-3">
                <div class="card-header bg-warning">⚠️ Low Stock (<?= $low_stock_count ?>)</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php while ($m = mysqli_fetch_assoc($low_stock)): ?>
                        <tr>
                            <td><?= htmlspecialchars($m['name']) ?></td>
                            <td class="text-danger"><strong><?= $m['stock_qty'] ?> left</strong></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
			<!-- 
                 <div class="card-footer"><a href="medicines/list.php" class="btn btn-sm btn-warning">View All</a></div>
-->	
            
			</div>
        </div>
        <div class="col-md-4">
            <div class="card border-danger mb-3">
                <div class="card-header bg-danger text-white">❌ Expired (<?= $expired_count ?>)</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php while ($m = mysqli_fetch_assoc($expired)): ?>
                        <tr>
                            <td><?= htmlspecialchars($m['name']) ?></td>
                            <td class="text-danger"><?= $m['expiry_date'] ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
				<!--
                <div class="card-footer"><a href="medicines/list.php" class="btn btn-sm btn-danger">View All</a></div>
            -->
			</div>
        </div>
       <div class="col-md-4">
    <div class="card border-info mb-3">
        <div class="card-header bg-info text-white">⏰ Expiring Soon (<?= $expiring_soon_count ?>)</div>
        <div class="card-body p-0">
            <table class="table table-sm mb-0">
                <?php
                $expiring = mysqli_query($conn, "SELECT * FROM medicines WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY) ORDER BY expiry_date ASC");
                while ($m = mysqli_fetch_assoc($expiring)):
                ?>
                <tr>
                    <td><?= htmlspecialchars($m['name']) ?></td>
                    <td class="text-warning"><strong><?= $m['expiry_date'] ?></strong></td>
                </tr>
                <?php endwhile; ?>
            </table>
        </div>
    </div>
</div>

    <div class="card">
        <div class="card-header"><strong>Recent Sales</strong></div>
        <div class="card-body p-0">
            <table class="table table-bordered mb-0">
                <thead class="table-dark">
                    <tr><th>Invoice #</th><th>Customer</th><th>Cashier</th><th>Payment</th><th>Total</th><th>Date</th><th>Action</th></tr>
                </thead>
                <tbody>
                <?php while ($row = mysqli_fetch_assoc($recent_sales)): ?>
                    <tr>
                        <td><?= str_pad($row['id'], 5, '0', STR_PAD_LEFT) ?></td>
                        <td><?= $row['customer_name'] ? htmlspecialchars($row['customer_name']) : 'Walk-in' ?></td>
                        <td><?= htmlspecialchars($row['cashier_name']) ?></td>
                        <td><?= strtoupper($row['payment_method']) ?></td>
                        <td>৳<?= number_format($row['total_amount'], 2) ?></td>
                        <td><?= date('d M Y', strtotime($row['created_at'])) ?></td>
                        <td><a href="sales/invoice.php?id=<?= $row['id'] ?>" class="btn btn-sm btn-info">Invoice</a></td>
                    </tr>
                <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ── PHARMACIST DASHBOARD ─────────────────────────────────────────────── -->
    <?php elseif ($role == 'pharmacist'): ?>

    <div class="row">
        <div class="col-md-3"><div class="stat-card" style="background:#2980b9;">
            <h6>Total Medicines</h6><h3><?= $total_medicines ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#8e44ad;">
            <h6>My Prescriptions</h6>
            <?php
            $my_rx = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM prescriptions WHERE pharmacist_id = {$_SESSION['user_id']}"))['total'];
            ?>
            <h3><?= $my_rx ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#e74c3c;">
            <h6>Expired Medicines</h6><h3><?= $expired_count ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#f39c12;">
            <h6>Low Stock Items</h6><h3><?= $low_stock_count ?></h3>
        </div></div>
    </div>

    <div class="row mt-2">
        <div class="col-md-6">
            <div class="card border-warning mb-3">
                <div class="card-header bg-warning">⚠️ Low Stock Medicines</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php
                        $ls2 = mysqli_query($conn, "SELECT * FROM medicines WHERE stock_qty <= min_threshold ORDER BY stock_qty ASC LIMIT 8");
                        while ($m = mysqli_fetch_assoc($ls2)): ?>
                        <tr>
                            <td><?= htmlspecialchars($m['name']) ?></td>
                            <td class="text-danger"><strong><?= $m['stock_qty'] ?> left</strong></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
                <div class="card-footer"><a href="medicines/list.php" class="btn btn-sm btn-warning">View All</a></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-primary mb-3">
                <div class="card-header bg-primary text-white">📝 Recent Prescriptions</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php
                        $rx = mysqli_query($conn, "SELECT * FROM prescriptions WHERE pharmacist_id = {$_SESSION['user_id']} ORDER BY created_at DESC LIMIT 8");
                        while ($r = mysqli_fetch_assoc($rx)): ?>
                        <tr>
                            <td><?= htmlspecialchars($r['patient_name']) ?></td>
                            <td><?= date('d M Y', strtotime($r['created_at'])) ?></td>
                            <td><a href="prescriptions/view.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-info">View</a></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
                <div class="card-footer"><a href="prescriptions/list.php" class="btn btn-sm btn-primary">View All</a></div>
            </div>
        </div>
    </div>

    <div class="row mt-2 text-center">
        <div class="col-md-4">
            <a href="medicines/list.php" class="btn btn-primary btn-lg w-100 mb-2">💊 View Medicines</a>
        </div>
        <div class="col-md-4">
            <a href="prescriptions/add.php" class="btn btn-success btn-lg w-100 mb-2">📝 New Prescription</a>
        </div>
        <div class="col-md-4">
            <a href="sales/create.php" class="btn btn-warning btn-lg w-100 mb-2">🛒 New Sale</a>
        </div>
    </div>

    <!-- ── CASHIER DASHBOARD ────────────────────────────────────────────────── -->
    <?php elseif ($role == 'cashier'): ?>

    <div class="row">
        <div class="col-md-4"><div class="stat-card" style="background:#27ae60;">
            <h6>Today's Sales</h6><h3>৳<?= number_format($today_sales, 2) ?></h3>
        </div></div>
        <div class="col-md-4"><div class="stat-card" style="background:#2980b9;">
            <h6>Total Transactions Today</h6>
            <?php
            $today_count = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) as total FROM sales WHERE DATE(created_at) = CURDATE()"))['total'];
            ?>
            <h3><?= $today_count ?></h3>
        </div></div>
        <div class="col-md-4"><div class="stat-card" style="background:#e67e22;">
            <h6>Total Sales (All Time)</h6><h3><?= $total_sales ?></h3>
        </div></div>
    </div>

    <div class="row mt-3 text-center">
        <div class="col-md-6">
            <a href="sales/create.php" class="btn btn-success btn-lg w-100 mb-3" style="padding:30px; font-size:20px;">
                🛒 New Sale / Billing
            </a>
        </div>
        <div class="col-md-6">
            <a href="sales/list.php" class="btn btn-primary btn-lg w-100 mb-3" style="padding:30px; font-size:20px;">
                📋 View Sales History
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-dark text-white"><strong>Today's Transactions</strong></div>
        <div class="card-body p-0">
            <table class="table table-bordered mb-0">
                <thead class="table-dark">
                    <tr><th>Invoice #</th><th>Customer</th><th>Payment</th><th>Total</th><th>Time</th><th>Action</th></tr>
                </thead>
                <tbody>
                <?php
                $today_tx = mysqli_query($conn, "SELECT * FROM sales WHERE DATE(created_at) = CURDATE() ORDER BY created_at DESC");
                while ($row = mysqli_fetch_assoc($today_tx)): ?>
                    <tr>
                        <td><?= str_pad($row['id'], 5, '0', STR_PAD_LEFT) ?></td>
                        <td><?= $row['customer_name'] ? htmlspecialchars($row['customer_name']) : 'Walk-in' ?></td>
                        <td><?= strtoupper($row['payment_method']) ?></td>
                        <td>৳<?= number_format($row['total_amount'], 2) ?></td>
                        <td><?= date('h:i A', strtotime($row['created_at'])) ?></td>
                        <td><a href="sales/invoice.php?id=<?= $row['id'] ?>" class="btn btn-sm btn-info">Invoice</a></td>
                    </tr>
                <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ── INVENTORY DASHBOARD ──────────────────────────────────────────────── -->
    <?php elseif ($role == 'inventory'): ?>

    <div class="row">
        <div class="col-md-3"><div class="stat-card" style="background:#8e44ad;">
            <h6>Total Medicines</h6><h3><?= $total_medicines ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#e74c3c;">
            <h6>Expired Medicines</h6><h3><?= $expired_count ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#f39c12;">
            <h6>Low Stock Items</h6><h3><?= $low_stock_count ?></h3>
        </div></div>
        <div class="col-md-3"><div class="stat-card" style="background:#1abc9c;">
            <h6>Total Suppliers</h6><h3><?= $total_suppliers ?></h3>
        </div></div>
    </div>

    <div class="row mt-2">
        <div class="col-md-6">
            <div class="card border-warning mb-3">
                <div class="card-header bg-warning">⚠️ Low Stock Medicines</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php
                        $ls3 = mysqli_query($conn, "SELECT * FROM medicines WHERE stock_qty <= min_threshold ORDER BY stock_qty ASC");
                        while ($m = mysqli_fetch_assoc($ls3)): ?>
                        <tr>
                            <td><?= htmlspecialchars($m['name']) ?></td>
                            <td class="text-danger"><strong><?= $m['stock_qty'] ?> left</strong></td>
                            <td><a href="medicines/edit.php?id=<?= $m['id'] ?>" class="btn btn-sm btn-warning">Restock</a></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-danger mb-3">
                <div class="card-header bg-danger text-white">❌ Expired Medicines</div>
                <div class="card-body p-0">
                    <table class="table table-sm mb-0">
                        <?php
                        $ex2 = mysqli_query($conn, "SELECT * FROM medicines WHERE expiry_date < CURDATE() ORDER BY expiry_date ASC");
                        while ($m = mysqli_fetch_assoc($ex2)): ?>
                        <tr>
                            <td><?= htmlspecialchars($m['name']) ?></td>
                            <td class="text-danger"><?= $m['expiry_date'] ?></td>
                            <td><a href="medicines/edit.php?id=<?= $m['id'] ?>" class="btn btn-sm btn-danger">Update</a></td>
                        </tr>
                        <?php endwhile; ?>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-2 text-center">
        <div class="col-md-4">
            <a href="medicines/list.php" class="btn btn-primary btn-lg w-100 mb-2">💊 Manage Medicines</a>
        </div>
        <div class="col-md-4">
            <a href="medicines/add.php" class="btn btn-success btn-lg w-100 mb-2">➕ Add Medicine</a>
        </div>
        <div class="col-md-4">
            <a href="suppliers/list.php" class="btn btn-secondary btn-lg w-100 mb-2">🚚 Manage Suppliers</a>
        </div>
    </div>

    <?php endif; ?>

</div><!-- end main-content -->
</div><!-- end row -->
</div><!-- end container-fluid -->
</body>
</html>