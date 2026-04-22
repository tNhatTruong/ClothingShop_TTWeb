package com.clothingshop.styleera.dao;

import com.clothingshop.styleera.model.ParentCategory;
import com.clothingshop.styleera.model.SubCategory;
import com.clothingshop.styleera.model.Variants;
import com.clothingshop.styleera.JDBiConnector.JDBIConnector;
import com.clothingshop.styleera.model.Product;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.stream.Collectors;

public class ProductDAO {

    // 1. Lấy sản phẩm mới nhất (Home)
    // Sắp xếp theo created_at giảm dần
    public List<Product> findNewArrivals() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, p.short_description, " +
                    "p.average_rating AS medium_rating, i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "ORDER BY p.created_at DESC LIMIT 8";
            return handle.createQuery(sql).mapToBean(Product.class).list();
        });
    }

    // 2. Lấy sản phẩm bán chạy (Home)
    // Sắp xếp theo average_rating giảm dần (giả lập bán chạy)
    public List<Product> findBestSellers() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, p.short_description, " +
                    "p.average_rating AS medium_rating, i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "ORDER BY p.average_rating DESC LIMIT 4";
            return handle.createQuery(sql).mapToBean(Product.class).list();
        });
    }

    // 3. Lấy tất cả sản phẩm (Trang Product)
    public List<Product> findAll() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "sc.id AS sub_id, sc.sub_name, sc.category_parent_id, " +
                    "pc.id AS parent_id, pc.parent_name, " +
                    "i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN subcategories sc ON p.category_sub_id = sc.id " +
                    "LEFT JOIN parentcategories pc ON sc.category_parent_id = pc.id " +
                    "LEFT JOIN images i ON p.image_id = i.id";

            return handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        // Tạo ParentCategory
                        ParentCategory parent = null;
                        int parentId = rs.getInt("parent_id");
                        if (parentId != 0) {
                            parent = new ParentCategory(parentId, rs.getString("parent_name"));
                        }

                        // Tạo SubCategory
                        SubCategory subcat = null;
                        int subId = rs.getInt("sub_id");
                        if (subId != 0) {
                            subcat = new SubCategory(subId, rs.getString("sub_name"), rs.getInt("category_parent_id"), null, null);
                            subcat.setCategory(parent);
                        }

                        // Tạo Product
                        Product product = new Product();
                        product.setProduct_id(rs.getInt("product_id"));
                        product.setProduct_name(rs.getString("product_name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setThumbnail(rs.getString("thumbnail"));
                        product.setSubcategory(subcat); // Đã sửa: setSubcategory

                        List<Variants> variants = findVariantsByProductId(rs.getInt("product_id"));
                        product.setVariants(variants);
                        return product;
                    })
                    .list();
        });
    }

    // 4. Lọc theo danh mục con (Trang Product)
    // Cột trong DB của bạn là: category_sub_id
    public List<Product> findBySubCategoryId(int subId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "p.average_rating AS medium_rating, i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE p.category_sub_id = ?";
            return handle.createQuery(sql).bind(0, subId).mapToBean(Product.class).list();
        });
    }

    // 5. Lọc theo danh mục cha (Trang Product)
    // JOIN bảng subcategories qua cột id, lọc bằng category_parent_id
    public List<Product> findByParentCategoryId(int parentId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "p.average_rating AS medium_rating, i.path AS thumbnail " +
                    "FROM products p " +
                    "JOIN subcategories s ON p.category_sub_id = s.id " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE s.category_parent_id = ?";
            return handle.createQuery(sql).bind(0, parentId).mapToBean(Product.class).list();
        });
    }

    // 6. Tìm chi tiết theo ID (Trang Detail)
    public List<Product> findById(int id){
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, p.short_description, " +
                    "p.detail_description, p.average_rating AS medium_rating, " +
                    "p.category_sub_id, p.created_at, p.updated_at, " +
                    "i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE p.id = ?";
            return handle.createQuery(sql).bind(0, id).mapToBean(Product.class).list();
        });
    }

    // 7. Lấy tất cả sản phẩm có sắp xếp (Dùng cho bộ lọc trang Product)
    public List<Product> findAllSorted(String sortType) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            StringBuilder sql = new StringBuilder(
                    "SELECT p.id AS product_id, p.product_name, p.price, " +
                            "p.average_rating AS medium_rating, i.path AS thumbnail " +
                            "FROM products p " +
                            "LEFT JOIN images i ON p.image_id = i.id "
            );

            // Logic nối chuỗi SQL dựa trên loại sắp xếp
            switch (sortType) {
                case "price_asc":
                    sql.append("ORDER BY p.price ASC");
                    break;
                case "price_desc":
                    sql.append("ORDER BY p.price DESC");
                    break;
                case "newest":
                    sql.append("ORDER BY p.created_at DESC");
                    break;
                case "bestseller":
                    sql.append("ORDER BY p.average_rating DESC");
                    break;
                default:
                    sql.append("ORDER BY p.id DESC");
                    break;
            }

            return handle.createQuery(sql.toString()).mapToBean(Product.class).list();
        });
    }

    // 8. Tìm thông tin chi tiết sản phẩm
    public Product findProductDetailById(int id) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id AS product_id, product_name, price, detail_description, " +
                    "short_description, average_rating AS medium_rating " +
                    "FROM products WHERE id = ?";
            return handle.createQuery(sql)
                    .bind(0, id)
                    .mapToBean(Product.class)
                    .findOne()
                    .orElse(null);
        });
    }

    // 9. Lấy danh sách ảnh phụ
    public List<String> findImagesByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT path FROM images WHERE product_id = :id")
                        .bind("id", productId)
                        .mapTo(String.class)
                        .list()
        );
    }

    // 10. Lấy danh sách Variants
    public List<Variants> findVariantsByProductId(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT id, size, color, quantity FROM variants WHERE product_id = :pid";
            return handle.createQuery(sql)
                    .bind("pid", productId)
                    .map((rs, ctx) -> {
                        Variants v = new Variants();
                        v.setVariantId(rs.getInt("id"));
                        v.setSize(rs.getString("size"));
                        v.setColor(rs.getString("color"));
                        v.setQuantity(rs.getInt("quantity"));
                        return v;
                    })
                    .list();
        });
    }

    // 11. Lấy sản phẩm liên quan
    public List<Product> findRelatedProducts(int subId, int prodId) {
        return JDBIConnector.getJdbi().withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE p.category_sub_id = :subId AND p.id != :prodId " +
                    "ORDER BY RAND() LIMIT 4";

            return handle.createQuery(sql)
                    .bind("subId", subId)
                    .bind("prodId", prodId)
                    .mapToBean(Product.class)
                    .list();
        });
    }

    //12. Lọc theo Danh Mục
    public List<Product> filterParentCategory(String parentName) {
        return JDBIConnector.getJdbi().withHandle(h -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "sc.id AS sub_id, sc.sub_name, sc.category_parent_id, " +
                    "pc.id AS parent_id, pc.parent_name, " +
                    "i.path AS thumbnail " +
                    "FROM products p " +
                    "JOIN subcategories sc ON p.category_sub_id = sc.id " +
                    "JOIN parentcategories pc ON sc.category_parent_id = pc.id " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE pc.parent_name = :parentName";

            return h.createQuery(sql)
                    .bind("parentName", parentName)
                    .map((rs, ctx) -> {
                        // Tạo ParentCategory
                        ParentCategory parent = null;
                        int parentId = rs.getInt("parent_id");
                        if (parentId != 0) {
                            parent = new ParentCategory(parentId, rs.getString("parent_name"));
                        }

                        // Tạo SubCategory
                        SubCategory subcat = null;
                        int subId = rs.getInt("sub_id");
                        if (subId != 0) {
                            subcat = new SubCategory(subId, rs.getString("sub_name"), rs.getInt("category_parent_id"), null, null);
                            subcat.setCategory(parent);
                        }

                        // Tạo Product
                        Product product = new Product();
                        product.setProduct_id(rs.getInt("product_id"));
                        product.setProduct_name(rs.getString("product_name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setThumbnail(rs.getString("thumbnail"));
                        product.setSubcategory(subcat); // Đã sửa: setSubcategory

                        List<Variants> variants = findVariantsByProductId(rs.getInt("product_id"));
                        product.setVariants(variants);
                        return product;
                    })
                    .list();
        });
    }

    //13. Lọc theo Phân Loại
    public List<Product> filterSubCategory(String subName) {
        return JDBIConnector.getJdbi().withHandle(h -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "sc.id AS sub_id, sc.sub_name, sc.category_parent_id, " +
                    "pc.id AS parent_id, pc.parent_name, " +
                    "i.path AS thumbnail " +
                    "FROM products p " +
                    "JOIN subcategories sc ON p.category_sub_id = sc.id " +
                    "LEFT JOIN parentcategories pc ON sc.category_parent_id = pc.id " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE sc.sub_name = :subName";

            return h.createQuery(sql)
                    .bind("subName", subName)
                    .map((rs, ctx) -> {
                        ParentCategory parent = new ParentCategory(rs.getInt("parent_id"), rs.getString("parent_name"));
                        SubCategory sub = new SubCategory(rs.getInt("sub_id"), rs.getString("sub_name"), rs.getInt("category_parent_id"), null, null);
                        sub.setCategory(parent);

                        Product product = new Product();
                        product.setProduct_id(rs.getInt("product_id"));
                        product.setProduct_name(rs.getString("product_name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setThumbnail(rs.getString("thumbnail"));
                        product.setSubcategory(sub); // Đã sửa: setSubcategory

                        product.setVariants(findVariantsByProductId(rs.getInt("product_id")));
                        return product;
                    })
                    .list();
        });
    }

    //14. Lọc sản phẩm theo Size và Color
    public List<Product> filterVariants(List<Product> products, String size, String color) {
        return products.stream()
                .filter(product -> {
                    if (product.getVariants() == null || product.getVariants().isEmpty()) {
                        return false;
                    }
                    return product.getVariants().stream()
                            .anyMatch(variant -> {
                                boolean matchSize = (size == null || size.isEmpty() || variant.getSize().equalsIgnoreCase(size));
                                boolean matchColor = (color == null || color.isEmpty() || variant.getColor().equalsIgnoreCase(color));
                                return matchSize && matchColor;
                            });
                })
                .collect(Collectors.toList());
    }

    //15. Lọc sản phẩm theo cả ParentCategory và SubCategory
    public List<Product> filterParentAndSubCategory(String parentName, String subName) {
        return JDBIConnector.getJdbi().withHandle(h -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "sc.id AS sub_id, sc.sub_name, sc.category_parent_id, " +
                    "pc.id AS parent_id, pc.parent_name, " +
                    "i.path AS thumbnail " +
                    "FROM products p " +
                    "JOIN subcategories sc ON p.category_sub_id = sc.id " +
                    "JOIN parentcategories pc ON sc.category_parent_id = pc.id " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "WHERE pc.parent_name = :parentName AND sc.sub_name = :subName";

            return h.createQuery(sql)
                    .bind("parentName", parentName)
                    .bind("subName", subName)
                    .map((rs, ctx) -> {
                        ParentCategory parent = new ParentCategory(rs.getInt("parent_id"), rs.getString("parent_name"));
                        SubCategory sub = new SubCategory(rs.getInt("sub_id"), rs.getString("sub_name"), rs.getInt("category_parent_id"), null, null);
                        sub.setCategory(parent);

                        Product product = new Product();
                        product.setProduct_id(rs.getInt("product_id"));
                        product.setProduct_name(rs.getString("product_name"));
                        product.setPrice(rs.getDouble("price"));
                        product.setThumbnail(rs.getString("thumbnail"));
                        product.setSubcategory(sub); // Đã sửa: setSubcategory
                        product.setVariants(findVariantsByProductId(rs.getInt("product_id")));

                        return product;
                    })
                    .list();
        });
    }

    //16. Cập nhật sản phẩm (edit)
    public boolean updateProducts(Product p) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        String sql = "Update Products" +
                " Set product_name = :name," +
                " price = :price," +
                " category_sub_id = :subID," +
                " updated_at = NOW()" +
                " Where id = :id";
        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("name", p.getProduct_name())
                        .bind("price", p.getPrice())
                        .bind("subID", p.getSubcategory().getId()) // Đã sửa: getSubcategory
                        .bind("id", p.getProduct_id())
                        .execute() > 0
        );
    }

    //17. Cập nhật biến thể (edit)
    public boolean updateVariantQuantity(int variantId, int quantity) {
        Jdbi jdbi = JDBIConnector.getJdbi();

        String sql = "UPDATE variants SET quantity = :qty WHERE id = :id";

        return jdbi.withHandle(h ->
                h.createUpdate(sql)
                        .bind("qty", quantity)
                        .bind("id", variantId)
                        .execute() > 0
        );
    }

    //17. Edit sản phẩm
    public void editProduct(Product product, int qty, int variantId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useTransaction(handle -> {
            boolean updatedProduct = handle.attach(ProductDAO.class).updateProducts(product);
            if (!updatedProduct) {
                throw new RuntimeException("Không cập nhật được product");
            }
            if (variantId > 0) {
                boolean updatedVariant = handle.attach(ProductDAO.class).updateVariantQuantity(variantId, qty);
                if (!updatedVariant) {
                    throw new RuntimeException("Không cập nhật được variant");
                }
            }
        });
    }

    // 18. tìm id theo product để edit
    public Product findProductEditById(int id) {
        Jdbi jdbi = JDBIConnector.getJdbi();

        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, " +
                    "sc.id AS sub_id, sc.sub_name, sc.category_parent_id, " +
                    "pc.id AS parent_id, pc.parent_name " +
                    "FROM products p " +
                    "JOIN subcategories sc ON p.category_sub_id = sc.id " +
                    "JOIN parentcategories pc ON sc.category_parent_id = pc.id " +
                    "WHERE p.id = ?";

            return handle.createQuery(sql)
                    .bind(0, id)
                    .map((rs, ctx) -> {
                        ParentCategory parent = new ParentCategory(rs.getInt("parent_id"), rs.getString("parent_name"));
                        SubCategory sub = new SubCategory(rs.getInt("sub_id"), rs.getString("sub_name"), rs.getInt("category_parent_id"), null, null);
                        sub.setCategory(parent);

                        Product p = new Product();
                        p.setProduct_id(rs.getInt("product_id"));
                        p.setProduct_name(rs.getString("product_name"));
                        p.setPrice(rs.getDouble("price"));
                        p.setSubcategory(sub); // Đã sửa: setSubcategory

                        return p;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

    // 19. Lấy top 5 sản phẩm bán chạy (Admin)
    public List<Product> findBestSellersAdmin() {
        Jdbi jdbi = JDBIConnector.getJdbi();
        return jdbi.withHandle(handle -> {
            String sql = "SELECT p.id AS product_id, p.product_name, p.price, p.short_description, " +
                    "p.average_rating AS medium_rating, i.path AS thumbnail " +
                    "FROM products p " +
                    "LEFT JOIN images i ON p.image_id = i.id " +
                    "ORDER BY p.average_rating DESC LIMIT 5";
            return handle.createQuery(sql).mapToBean(Product.class).list();
        });
    }

    //20. tính tổng giá tiền của sản phẩm:
    public double getTotalProductPrice() {
        return JDBIConnector.getJdbi().withHandle(handle ->
                handle.createQuery("SELECT SUM(price) AS price FROM products")
                        .mapToBean(Product.class)
                        .findOne()
                        .map(Product::getPrice)
                        .orElse(0.0)
        );
    }

    //21. Xoá product theo id
    public void deleleteProduct(int productId) {
        Jdbi jdbi = JDBIConnector.getJdbi();
        jdbi.useTransaction(handle -> {
            handle.createUpdate("DELETE od FROM orderdetails od JOIN variants v ON od.variant_id = v.id WHERE v.product_id = ?").bind(0, productId).execute();
            handle.createUpdate("DELETE FROM review WHERE product_id = ?").bind(0, productId).execute();
            handle.createUpdate("DELETE FROM variants WHERE product_id = ?").bind(0, productId).execute();
            handle.createUpdate("DELETE FROM products WHERE id = ?").bind(0, productId).execute();
        });
    }
    //22. Thêm product  trong trang admin quan ly san pham
    public void insertProductFull(
            String productName,
            int subCategoryId,
            double price,
            String shortDesc,
            String detailDesc,
            String size,
            String color,
            int quantity,
            String imageName,
            String imagePath
    ) {

        JDBIConnector.getJdbi().useTransaction(handle -> {

            // thêm dl sản phẩm
            int productId = handle.createUpdate("  INSERT INTO products\n" +
                            "                (category_sub_id, product_name, average_rating,\n" +
                            "                 short_description, detail_description, price, created_at)\n" +
                            "                VALUES (?, ?, 0, ?, ?, ?, NOW())")
                    .bind(0, subCategoryId)
                    .bind(1, productName)
                    .bind(2, shortDesc)
                    .bind(3, detailDesc)
                    .bind(4, price)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
            // thêm dl biến thể

            handle.createUpdate(" INSERT INTO variants\n" +
                            "                (product_id, size, color, quantity)\n" +
                            "                VALUES (?, ?, ?, ?)")
                    .bind(0, productId)
                    .bind(1, size)
                    .bind(2, color)
                    .bind(3, quantity)
                    .execute();

            // thêm dl ảnh
            handle.createUpdate(" INSERT INTO images (product_id, image_name, path, updated_at)VALUES (?, ?, ?, NOW())")
                    .bind(0, productId)
                    .bind(1, imageName)
                    .bind(2, imagePath)
                    .execute();
        });
    }

}