<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Premium User Profile</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #d4af37; /* Gold */
      --secondary-color: #e6c75f;
      --dark-color: #1a1a1a;
      --light-color: #ffffff;
      --sidebar-width: 280px;
      --transition: all 0.3s ease;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: var(--light-color);
      color: var(--dark-color);
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      width: var(--sidebar-width);
      background-color: var(--dark-color);
      color: var(--primary-color);
      padding: 30px 0;
      position: fixed;
      height: 100vh;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
      transition: var(--transition);
      z-index: 100;
    }

    .profile-info {
      text-align: center;
      padding: 0 20px 30px;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .profile-pic {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      object-fit: cover;
      border: 3px solid var(--primary-color);
      margin-bottom: 15px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .profile-name {
      font-size: 1.2rem;
      font-weight: 600;
      color: white;
    }

    .profile-role {
      font-size: 0.85rem;
      color: var(--primary-color);
      margin-bottom: 20px;
    }

    .nav-menu {
      padding: 30px 0;
    }

    .nav-item {
      margin-bottom: 5px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      padding: 12px 25px;
      color: white;
      text-decoration: none;
      transition: var(--transition);
    }

    .nav-link:hover, .nav-link.active {
      background-color: rgba(255, 255, 255, 0.1);
      border-left: 4px solid var(--primary-color);
    }

    .nav-link i {
      margin-right: 15px;
      font-size: 1.1rem;
      width: 20px;
      text-align: center;
    }

    .main-content {
      flex: 1;
      margin-left: var(--sidebar-width);
      padding: 40px;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }

    .header h1 {
      font-size: 1.8rem;
      color: var(--dark-color);
      font-weight: 700;
    }

    .user-actions {
      display: flex;
      gap: 15px;
    }

    .btn {
      padding: 10px 20px;
      border-radius: 6px;
      border: none;
      cursor: pointer;
      font-weight: 500;
      transition: var(--transition);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .btn-primary {
      background-color: var(--primary-color);
      color: var(--dark-color);
    }

    .btn-primary:hover {
      background-color: #c9a037;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }

    .btn-outline {
      background-color: transparent;
      border: 1px solid #ccc;
      color: var(--dark-color);
    }

    .btn-outline:hover {
      background-color: #f9f9f9;
    }

    .form-container {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 5px 25px rgba(0, 0, 0, 0.05);
      padding: 30px;
    }

    .form-title {
      font-size: 1.4rem;
      margin-bottom: 25px;
      color: var(--dark-color);
      padding-bottom: 15px;
      border-bottom: 1px solid #eee;
    }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #444;
    }

    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ddd;
      border-radius: 6px;
      font-size: 0.95rem;
      transition: var(--transition);
    }

    .form-control:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(212, 175, 55, 0.2);
      outline: none;
    }

    .photo-upload {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100%;
    }

    .photo-preview {
      width: 180px;
      height: 180px;
      border-radius: 50%;
      object-fit: cover;
      border: 5px solid #f1f1f1;
      margin-bottom: 20px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .upload-btn {
      position: relative;
      overflow: hidden;
      display: inline-block;
    }

    .upload-btn input[type="file"] {
      position: absolute;
      left: 0;
      top: 0;
      opacity: 0;
      width: 100%;
      height: 100%;
      cursor: pointer;
    }

    .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 15px;
      margin-top: 30px;
      padding-top: 20px;
      border-top: 1px solid #eee;
    }

    @media (max-width: 992px) {
      .form-grid {
        grid-template-columns: 1fr;
      }

      .sidebar {
        transform: translateX(-100%);
      }

      .main-content {
        margin-left: 0;
      }

      .sidebar.active {
        transform: translateX(0);
      }

      .menu-toggle {
        display: block !important;
      }
    }

    .menu-toggle {
      display: none;
      background: none;
      border: none;
      font-size: 1.5rem;
      cursor: pointer;
      color: var(--dark-color);
    }
  </style>
</head>
<body>
  <div class="sidebar" id="sidebar">
    <div class="profile-info">
      <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Profile Picture" class="profile-pic" id="sidebarProfilePic">
      <h3 class="profile-name" id="sidebarName">John Doe</h3>
      <p class="profile-role">Premium Member</p>
    </div>
    <div class="nav-menu">
      <div class="nav-item"><a href="#" class="nav-link active"><i class="fas fa-user"></i> <span>Profile</span></a></div>
      <div class="nav-item"><a href="#" class="nav-link"><i class="fas fa-cog"></i> <span>Settings</span></a></div>
      <div class="nav-item"><a href="#" class="nav-link"><i class="fas fa-lock"></i> <span>Security</span></a></div>
      <div class="nav-item"><a href="#" class="nav-link"><i class="fas fa-bell"></i> <span>Notifications</span></a></div>
      <div class="nav-item"><a href="#" class="nav-link"><i class="fas fa-credit-card"></i> <span>Billing</span></a></div>
      <div class="nav-item"><a href="../LoginPage.jsp" class="nav-link"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></div>
    </div>
  </div>

  <div class="main-content">
    <div class="header">
      <button class="menu-toggle" id="menuToggle"><i class="fas fa-bars"></i></button>
      <h1>Edit Profile</h1>
      <div class="user-actions">
        <button class="btn btn-outline"><i class="fas fa-times"></i> Cancel</button>
        <button class="btn btn-primary" onclick="submitForm()"><i class="fas fa-save"></i> Save Changes</button>
      </div>
    </div>

    <div class="form-container">
      <h2 class="form-title">Personal Information</h2>
      <form id="profileForm">
        <div class="form-grid">
          <div class="form-column">
            <div class="form-group"><label for="name">Full Name</label><input type="text" id="name" name="name" class="form-control" required></div>
            <div class="form-group"><label for="email">Email Address</label><input type="email" id="email" name="email" class="form-control" required></div>
            <div class="form-group"><label for="phone">Phone Number</label><input type="tel" id="phone" name="phone" class="form-control"></div>
            <div class="form-group"><label for="dob">Date of Birth</label><input type="date" id="dob" name="dob" class="form-control"></div>
            <div class="form-group">
              <label for="gender">Gender</label>
              <select id="gender" name="gender" class="form-control" required>
                <option value="">Select gender</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
              </select>
            </div>
          </div>
          <div class="form-column">
            <div class="photo-upload">
              <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Profile Preview" class="photo-preview" id="profilePic">
              <div class="upload-btn">
                <button type="button" class="btn btn-primary"><i class="fas fa-camera"></i> Upload Photo</button>
                <input type="file" id="photo" name="photo" accept="image/*" onchange="displayProfilePic()">
              </div>
              <p style="margin-top: 15px; color: #777; font-size: 0.85rem;">Recommended size: 300x300px, JPG, PNG or GIF</p>
            </div>
          </div>
        </div>
        <div class="form-actions">
          <button type="button" class="btn btn-outline"><i class="fas fa-times"></i> Cancel</button>
          <button type="button" class="btn btn-primary" onclick="submitForm()"><i class="fas fa-save"></i> Save Changes</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    function displayProfilePic() {
      const input = document.getElementById('photo');
      const img = document.getElementById('profilePic');
      const sidebarImg = document.getElementById('sidebarProfilePic');
      if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
          img.src = e.target.result;
          sidebarImg.src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
      }
    }

    function submitForm() {
      const formData = new FormData(document.getElementById('profileForm'));
      const name = document.getElementById('name').value;
      if (name) {
        document.getElementById('sidebarName').textContent = name;
      }
      for (const pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
      }
      alert('Profile updated successfully!');
    }

    document.getElementById('menuToggle').addEventListener('click', function() {
      document.getElementById('sidebar').classList.toggle('active');
    });

    window.onload = function() {
      document.getElementById('name').value = 'John Doe';
      document.getElementById('email').value = 'john.doe@example.com';
      document.getElementById('phone').value = '+1 (555) 123-4567';
      document.getElementById('dob').value = '1990-01-01';
      document.getElementById('gender').value = 'male';
    };
  </script>
</body>
</html>
