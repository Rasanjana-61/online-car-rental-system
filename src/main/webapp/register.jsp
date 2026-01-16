<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create User | Premium Car Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bcryptjs/2.4.3/bcrypt.min.js"></script>
    <style>
        .auth-bg {
            background-image: url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1280&q=80');
            background-size: cover;
            background-position: center;
        }

        .header-bg {
            background-image: url('assets/header-orange-black.png');
            background-size: cover;
            background-position: center;
            height: 80px;
        }
        
        .error-message {
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        
        .password-strength {
            height: 4px;
            margin-top: 4px;
            border-radius: 2px;
        }
        
        .strength-0 { background-color: #ef4444; width: 20%; }
        .strength-1 { background-color: #f97316; width: 40%; }
        .strength-2 { background-color: #f59e0b; width: 60%; }
        .strength-3 { background-color: #84cc16; width: 80%; }
        .strength-4 { background-color: #10b981; width: 100%; }
        
        .role-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .badge-customer { background-color: #f59e0b; color: white; }
        .badge-employee { background-color: #3b82f6; color: white; }
        .badge-admin { background-color: #ef4444; color: white; }
        .badge-premium { background-color: #8b5cf6; color: white; }
    </style>
</head>

<body class="bg-gray-100 font-sans">
    <div id="header-container"></div>
    <%@ include file="header/header2.jsp"%>

    <main class="min-h-[calc(100vh-160px)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-5xl w-full flex bg-white rounded-xl shadow-lg overflow-hidden">
            <!-- Left Side - Form -->
            <div class="w-full md:w-1/2 p-8 sm:p-12">
                <div class="text-center mb-8">
                    <h1 class="text-3xl font-bold text-gray-800">Create New User</h1>
                    <p class="text-gray-600 mt-2">Add a new user to the system</p>
                </div>

                <form id="createUserForm" action="user" method="POST">
                    <input type="hidden" name="action" value="create">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="fname" class="block text-sm font-medium text-gray-700">First Name</label>
                            <input id="fname" name="fname" type="text" required
                                class="mt-1 block w-full py-3 px-4 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="John">
                            <div id="fname-error" class="error-message hidden">Please enter first name</div>
                        </div>
                        <div>
                            <label for="lname" class="block text-sm font-medium text-gray-700">Last Name</label>
                            <input id="lname" name="lname" type="text" required
                                class="mt-1 block w-full py-3 px-4 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="Doe">
                            <div id="lname-error" class="error-message hidden">Please enter last name</div>
                        </div>
                    </div>

                    <div class="mt-6">
                        <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                        <div class="mt-1 relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-mail-line text-gray-400"></i>
                            </div>
                            <input id="email" name="email" type="email" required
                                class="pl-10 block w-full py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="you@example.com">
                        </div>
                        <div id="email-error" class="error-message hidden">Please enter a valid email</div>
                    </div>

                    <div class="mt-6">
                        <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                        <div class="mt-1 relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-phone-line text-gray-400"></i>
                            </div>
                            <input id="phone" name="phone" type="tel" required
                                class="pl-10 block w-full py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="+1 (555) 123-4567">
                        </div>
                        <div id="phone-error" class="error-message hidden">Please enter phone number</div>
                    </div>

                    <!-- Enhanced User Role Selection -->
                    <div class="mt-6">
                        <label for="userrole" class="block text-sm font-medium text-gray-700">User Role</label>
                        <div class="mt-1 relative">
                            <select id="userrole" name="userrole" required
                                class="block w-full py-3 px-4 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500 bg-white appearance-none">
                                <option value="Customer" selected>Customer</option>
                                <option value="Employee">Employee</option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <i class="ri-arrow-down-s-line text-gray-400"></i>
                            </div>
                        </div>
                        <div class="mt-2 flex gap-2">
                            <span class="role-badge badge-customer"><i class="ri-user-line mr-1"></i> Customer</span>
                            <span class="role-badge badge-employee"><i class="ri-briefcase-line mr-1"></i> Employee</span>
                        </div>
                    </div>

                    <div class="mt-6">
                        <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                        <div class="mt-1 relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-lock-line text-gray-400"></i>
                            </div>
                            <input id="password" name="password" type="password" required
                                class="pl-10 block w-full py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="••••••••">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                <button type="button" class="text-gray-400 hover:text-gray-500" id="togglePassword">
                                    <i class="ri-eye-line" id="eyeIcon"></i>
                                </button>
                            </div>
                        </div>
                        <div id="password-strength" class="password-strength strength-0"></div>
                        <div id="password-error" class="error-message hidden">Password must be at least 8 characters with uppercase, lowercase, number, and special character</div>
                    </div>

                    <div class="mt-6">
                        <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                        <div class="mt-1 relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <i class="ri-lock-line text-gray-400"></i>
                            </div>
                            <input id="confirmPassword" name="confirmPassword" type="password" required
                                class="pl-10 block w-full py-3 border border-gray-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
                                placeholder="••••••••">
                            <div class="absolute inset-y-0 right-0 pr-3 flex items-center">
                                <button type="button" class="text-gray-400 hover:text-gray-500" id="toggleConfirmPassword">
                                    <i class="ri-eye-line" id="eyeConfirmIcon"></i>
                                </button>
                            </div>
                        </div>
                        <div id="confirmPassword-error" class="error-message hidden">Passwords do not match</div>
                    </div>

                    <div class="mt-8">
                        <button type="submit" id="submitButton"
                            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-yellow-600 hover:bg-yellow-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500 transition">
                            Create User <i class="ri-arrow-right-line ml-2"></i>
                        </button>
                    </div>
                </form>

                <div class="mt-8 text-center">
                    <p class="text-sm text-gray-600">
                        <a href="user" class="font-medium text-yellow-600 hover:text-yellow-500">Back to User List</a>
                    </p>
                </div>
            </div>

            <!-- Right Side - Image -->
            <div class="hidden md:block md:w-1/2 auth-bg relative">
                <div class="absolute inset-0 bg-black bg-opacity-40 flex items-center justify-center p-8">
                    <div class="text-white text-center">
                        <i class="ri-steering-2-fill text-5xl mb-4 text-yellow-500"></i>
                        <h2 class="text-3xl font-bold mb-4">User Management</h2>
                        <ul class="text-left space-y-3 max-w-md mx-auto">
                            <li class="flex items-center"><i class="ri-checkbox-circle-fill text-yellow-400 mr-2"></i>
                                Create and manage system users</li>
                            <li class="flex items-center"><i class="ri-checkbox-circle-fill text-yellow-400 mr-2"></i>
                                Set appropriate access levels</li>
                            <li class="flex items-center"><i class="ri-checkbox-circle-fill text-yellow-400 mr-2"></i>
                                Track user activity</li>
                            <li class="flex items-center"><i class="ri-checkbox-circle-fill text-yellow-400 mr-2"></i>
                                Maintain security standards</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <%@ include file="footer.jsp"%>

    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');
            togglePasswordVisibility(passwordInput, eyeIcon);
        });

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmInput = document.getElementById('confirmPassword');
            const eyeIcon = document.getElementById('eyeConfirmIcon');
            togglePasswordVisibility(confirmInput, eyeIcon);
        });

        function togglePasswordVisibility(inputElement, iconElement) {
            if (inputElement.type === 'password') {
                inputElement.type = 'text';
                iconElement.classList.remove('ri-eye-line');
                iconElement.classList.add('ri-eye-off-line');
            } else {
                inputElement.type = 'password';
                iconElement.classList.remove('ri-eye-off-line');
                iconElement.classList.add('ri-eye-line');
            }
        }

        // Dynamic role-based button styling
        document.getElementById('userrole').addEventListener('change', function() {
            const role = this.value;
            const submitBtn = document.getElementById('submitButton');
            
            // Reset classes
            submitBtn.className = 'w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white focus:outline-none focus:ring-2 focus:ring-offset-2 transition';
            
            // Add role-specific classes
            switch(role) {
                case 'Premium':
                    submitBtn.classList.add('bg-purple-600', 'hover:bg-purple-700', 'focus:ring-purple-500');
                    submitBtn.innerHTML = 'Create Premium Member <i class="ri-star-fill ml-2"></i>';
                    break;
                case 'Admin':
                    submitBtn.classList.add('bg-red-600', 'hover:bg-red-700', 'focus:ring-red-500');
                    submitBtn.innerHTML = 'Create Administrator <i class="ri-shield-keyhole-fill ml-2"></i>';
                    break;
                case 'Employee':
                    submitBtn.classList.add('bg-blue-600', 'hover:bg-blue-700', 'focus:ring-blue-500');
                    submitBtn.innerHTML = 'Create Employee <i class="ri-briefcase-fill ml-2"></i>';
                    break;
                default: // Customer
                    submitBtn.classList.add('bg-yellow-600', 'hover:bg-yellow-700', 'focus:ring-yellow-500');
                    submitBtn.innerHTML = 'Create Customer <i class="ri-user-fill ml-2"></i>';
            }
        });

        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('password-strength');
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength++;
            // Contains uppercase
            if (/[A-Z]/.test(password)) strength++;
            // Contains lowercase
            if (/[a-z]/.test(password)) strength++;
            // Contains number
            if (/[0-9]/.test(password)) strength++;
            // Contains special char
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            // Update strength meter
            strengthBar.className = 'password-strength strength-' + strength;
        });

        // Form validation
        document.getElementById('createUserForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            let isValid = true;
            
            // Reset error messages
            document.querySelectorAll('.error-message').forEach(el => {
                el.classList.add('hidden');
            });

            // Validate first name
            if (!document.getElementById('fname').value.trim()) {
                document.getElementById('fname-error').classList.remove('hidden');
                isValid = false;
            }

            // Validate last name
            if (!document.getElementById('lname').value.trim()) {
                document.getElementById('lname-error').classList.remove('hidden');
                isValid = false;
            }

            // Validate email
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('email-error').classList.remove('hidden');
                isValid = false;
            }

            // Validate phone
            if (!document.getElementById('phone').value.trim()) {
                document.getElementById('phone-error').classList.remove('hidden');
                isValid = false;
            }

            // Validate password
            const password = document.getElementById('password').value;
            if (password.length < 8 || !/[A-Z]/.test(password) || !/[a-z]/.test(password) || !/[0-9]/.test(password) || !/[^A-Za-z0-9]/.test(password)) {
                document.getElementById('password-error').classList.remove('hidden');
                isValid = false;
            }

            // Validate password match
            if (password !== document.getElementById('confirmPassword').value) {
                document.getElementById('confirmPassword-error').classList.remove('hidden');
                isValid = false;
            }

            if (isValid) {
                // Hash the password with bcrypt
                const salt = bcrypt.genSaltSync(10);
                const hashedPassword = bcrypt.hashSync(password, salt);
                
                // Create hidden field for hashed password
                const hiddenPassword = document.createElement('input');
                hiddenPassword.type = 'hidden';
                hiddenPassword.name = 'hashedPassword';
                hiddenPassword.value = hashedPassword;
                this.appendChild(hiddenPassword);
                
                // Submit the form
                this.submit();
            }
        });
    </script>
</body>
</html>