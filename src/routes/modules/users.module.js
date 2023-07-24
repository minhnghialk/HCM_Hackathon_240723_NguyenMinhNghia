import express from "express";
const router = express.Router();
import path from "path";
import multiparty from "multiparty";

router.get("/", (req, res) => {
  fs.readFile(path.join(__dirname, "user.json"), "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({
        message: "Lấy users thất bại!",
      });
    }
    return res.status(200).json({
      message: "Lấy users thành công!",
      data: JSON.parse(data),
    });
  });
});

router.delete("/:userId", (req, res) => {
  if (req.params.userId) {
    fs.readFile(path.join(__dirname, "user.json"), "utf-8", (err, data) => {
      if (err) {
        return res.status(500).json({
          message: "Lấy users thất bại!",
        });
      }
      let users = JSON.parse(data);
      let userDelete = users.find((user) => user.id == req.params.userId);
      users = users.filter((user) => user.id != req.params.userId);

      fs.writeFile(
        path.join(__dirname, "user.json"),
        JSON.stringify(users),
        (err) => {
          if (err) {
            return res.status(500).json({
              message: "Lưu file thất bại!",
            });
          }
          res.sendStatus(200);
        }
      );
    });
  } else {
    return res.status(500).json({
      message: "Vui lòng truyền userId!",
    });
  }
});

router.post("/", (req, res) => {
  let form = new multiparty.Form();

  form.parse(req, (err, fields, files) => {
    if (err) {
      return res.status(500).send("Lỗi đọc form!");
    }

    let newUser = {
      id: Date.now(),
      name: fields.name[0],
      completed: false,
    };

    fs.readFile(path.join(__dirname, "todo.json"), "utf-8", (err, data) => {
      if (err) {
        return res.status(500).json({
          message: "Đọc dữ liệu thất bại!",
        });
      }

      let oldData = JSON.parse(data);
      oldData.push(newUser);

      fs.writeFile(
        path.join(__dirname, "user.json"),
        JSON.stringify(oldData),
        (err) => {
          if (err) {
            return res.status(500).json({
              message: "Ghi file thất bại!",
            });
          }
          return res.redirect("/users");
        }
      );
    });
  });
});

router.delete("/", (req, res) => {
  fs.writeFile(path.join(__dirname, "user.json"), "[]", (err) => {
    if (err) {
      return res.status(500).json({
        message: "Xoá tất cả các tasks thất bại!",
      });
    }
    res.sendStatus(200);
  });
});

router.put("/:userId", (req, res) => {
  if (req.params.userId) {
    fs.readFile(path.join(__dirname, "user.json"), "utf-8", (err, data) => {
      if (err) {
        return res.status(500).json({
          message: "Lấy users thất bại!",
        });
      }
      let users = JSON.parse(data);
      let userToUpdate = users.find((user) => user.id == req.params.userId);

      if (!userToUpdate) {
        return res.status(404).json({
          message: "Không tìm thấy task!",
        });
      }

      userToUpdate.completed = !userToUpdate.completed;

      fs.writeFile(
        path.join(__dirname, "user.json"),
        JSON.stringify(users),
        (err) => {
          if (err) {
            return res.status(500).json({
              message: "Lưu file thất bại!",
            });
          }
          res.sendStatus(200);
        }
      );
    });
  } else {
    return res.status(500).json({
      message: "Vui lòng truyền userId!",
    });
  }
});

module.exports = router;
