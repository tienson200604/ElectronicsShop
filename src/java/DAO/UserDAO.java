package DAO;

import Model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public static User getUserByUsername(String username) {
        User user = null;

        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = mapRowToUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public static boolean updateVerification(String email, String code, Timestamp expiresAt) {
        String sql = "UPDATE users SET verification_code=?, verification_expires_at=? WHERE email=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, code);
            stmt.setTimestamp(2, expiresAt);
            stmt.setString(3, email);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static boolean verifyEmail(String email) {
        String sql = "UPDATE users SET email_verified = 1, verification_code = NULL, verification_expires_at = NULL WHERE email = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private static User mapRowToUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRoleId(rs.getInt("role_id"));
        u.setEmailVerified(rs.getInt("email_verified"));
        u.setVerificationCode(rs.getString("verification_code"));
        u.setVerificationExpiresAt(rs.getString("verification_expires_at"));
        return u;
    }
    public static User getUserByEmail(String email) {
    User user = null;
    String sql = "SELECT * FROM users WHERE email=?";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            user = mapRowToUser(rs);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return user;
}

public static int insertNewUser(String username, String password, String fullName, String email, String phone) {
    String sql = "INSERT INTO users(username, password_hash, full_name, email, phone, role_id, email_verified) VALUES (?, ?, ?, ?, ?, 2, 0)";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        stmt.setString(1, username);
        stmt.setString(2, password);
        stmt.setString(3, fullName);
        stmt.setString(4, email);
        stmt.setString(5, phone);

        int affected = stmt.executeUpdate();
        if (affected == 0) return -1;

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) return rs.getInt(1);

    } catch (Exception e) {
        e.printStackTrace();
    }

    return -1;
}

}
    