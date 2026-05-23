<?php
session_start();
require_once 'config/db.php';

$error = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email    = trim($_POST['email']);
    $password = trim($_POST['password']);

    $sql    = "SELECT * FROM users WHERE email = ?";
    $stmt   = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "s", $email);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $user   = mysqli_fetch_assoc($result);

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id']   = $user['id'];
        $_SESSION['user_name'] = $user['name'];
        $_SESSION['role']      = $user['role'];
        header("Location: dashboard.php");
        exit();
    } else {
        $error = "Invalid email or password.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Satota Pharmacy & Departmental Store — Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --green-deep:   #1a4d3a;
            --green-mid:    #2e7d57;
            --green-light:  #4caf82;
            --gold:         #c9a84c;
            --gold-light:   #e8c97a;
            --cream:        #faf8f3;
            --text-dark:    #1c1c1c;
            --text-muted:   #6b7280;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            min-height: 100vh;
            font-family: 'DM Sans', sans-serif;
            background: var(--cream);
            display: flex;
            align-items: stretch;
        }

        /* ── Left panel ── */
        .left-panel {
            width: 45%;
            background: var(--green-deep);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 60px 48px;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            width: 420px; height: 420px;
            border-radius: 50%;
            border: 60px solid rgba(255,255,255,0.04);
            top: -100px; left: -100px;
        }
        .left-panel::after {
            content: '';
            position: absolute;
            width: 300px; height: 300px;
            border-radius: 50%;
            border: 40px solid rgba(201,168,76,0.1);
            bottom: -80px; right: -80px;
        }

        .brand-icon {
            width: 72px; height: 72px;
            background: linear-gradient(135deg, var(--gold), var(--gold-light));
            border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            font-size: 32px;
            color: var(--green-deep);
            margin-bottom: 28px;
            box-shadow: 0 8px 24px rgba(201,168,76,0.3);
            position: relative; z-index: 1;
        }

        .brand-name {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 700;
            color: #fff;
            text-align: center;
            line-height: 1.3;
            position: relative; z-index: 1;
        }

        .brand-name span {
            display: block;
            font-size: 13px;
            font-family: 'DM Sans', sans-serif;
            font-weight: 400;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: var(--gold-light);
            margin-top: 8px;
        }

        .divider-gold {
            width: 48px; height: 2px;
            background: linear-gradient(90deg, transparent, var(--gold), transparent);
            margin: 24px auto;
            position: relative; z-index: 1;
        }

        .tagline {
            color: rgba(255,255,255,0.55);
            font-size: 13.5px;
            text-align: center;
            line-height: 1.7;
            max-width: 260px;
            position: relative; z-index: 1;
        }

        .info-pills {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 40px;
            width: 100%;
            max-width: 280px;
            position: relative; z-index: 1;
        }

        .info-pill {
            display: flex;
            align-items: center;
            gap: 12px;
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 10px;
            padding: 12px 16px;
            color: rgba(255,255,255,0.75);
            font-size: 13px;
        }

        .info-pill i {
            color: var(--gold-light);
            font-size: 16px;
            flex-shrink: 0;
        }

        /* ── Right panel ── */
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 40px;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
        }

        .login-heading {
            font-family: 'Playfair Display', serif;
            font-size: 26px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .login-sub {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 36px;
        }

        .form-label {
            font-size: 13px;
            font-weight: 500;
            color: var(--text-dark);
            margin-bottom: 6px;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap .input-icon {
            position: absolute;
            left: 14px; top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 16px;
            pointer-events: none;
        }

        .form-control {
            padding: 12px 14px 12px 42px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            font-family: 'DM Sans', sans-serif;
            background: #fff;
            transition: border-color .2s, box-shadow .2s;
        }

        .form-control:focus {
            border-color: var(--green-mid);
            box-shadow: 0 0 0 3px rgba(46,125,87,0.12);
            outline: none;
        }

        .btn-login {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, var(--green-deep), var(--green-mid));
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            margin-top: 8px;
            letter-spacing: 0.3px;
            transition: opacity .2s, transform .15s;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }

        .btn-login:hover { opacity: 0.92; transform: translateY(-1px); }
        .btn-login:active { transform: translateY(0); }

        .alert-danger {
            background: #fff5f5;
            border: 1px solid #fca5a5;
            color: #b91c1c;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 13.5px;
            margin-bottom: 20px;
            display: flex; align-items: center; gap: 8px;
        }

        .footer-note {
            text-align: center;
            margin-top: 32px;
            font-size: 12px;
            color: var(--text-muted);
        }

        @media (max-width: 768px) {
            body { flex-direction: column; }
            .left-panel { width: 100%; padding: 40px 24px; }
            .info-pills { display: none; }
        }
    </style>
</head>
<body>

<!-- Left branding panel -->
<div class="left-panel">
    <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>

    <div class="brand-name">
        Satota Pharmacy<br>&amp; Departmental Store
        <span>Management System</span>
    </div>

    <div class="divider-gold"></div>

    <p class="tagline">Streamlining pharmacy operations with precision, care, and efficiency.</p>

    <div class="info-pills">
        <div class="info-pill">
            <i class="bi bi-geo-alt-fill"></i>
            Vai Vai Plaza, Sector 10, Uttara, Dhaka
        </div>
        <div class="info-pill">
            <i class="bi bi-clock-fill"></i>
            Open: 8:00 AM – 10:00 PM, 7 days a week
        </div>
        <div class="info-pill">
            <i class="bi bi-telephone-fill"></i>
            01621840038
        </div>
    </div>
</div>

<!-- Right login panel -->
<div class="right-panel">
    <div class="login-card">
        <h1 class="login-heading">Welcome back</h1>
        <p class="login-sub">Sign in to access the management portal</p>

        <?php if ($error): ?>
            <div class="alert-danger">
                <i class="bi bi-exclamation-circle-fill"></i>
                <?= htmlspecialchars($error) ?>
            </div>
        <?php endif; ?>

        <form method="POST">
            <div class="mb-4">
                <label class="form-label">Email Address</label>
                <div class="input-wrap">
                    <i class="bi bi-envelope input-icon"></i>
                    <input type="email" name="email" class="form-control" placeholder="admin@pharmacy.com" required>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-wrap">
                    <i class="bi bi-lock input-icon"></i>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
            </div>
            <button type="submit" class="btn-login">
                <i class="bi bi-box-arrow-in-right"></i> Sign In
            </button>
        </form>

        <p class="footer-note">© <?= date('Y') ?> Satota Pharmacy &amp; Departmental Store. All rights reserved.</p>
    </div>
</div>

</body>
</html>