package com.kosa.starrydonuts.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kosa.starrydonuts.domain.CommentDTO;
import com.kosa.starrydonuts.service.CommentService;

@Controller
public class CommentController {

   @Autowired
   private CommentService service;
   
   
   //1. 댓글 작성하기
   @ResponseBody
   @RequestMapping(value="/comment/register.do", method = RequestMethod.POST)
   public Map<String, Object> register(@RequestBody CommentDTO comment) throws Exception {
      System.out.println("comment.controller.register() invoked.");
      
      Map<String, Object> result = new HashMap<>();
      boolean status = service.commentInsert(comment);
      
      if(status) {      
         result.put("status", true);
         result.put("message", "댓글이 등록되었습니다.");
         result.put("comment", service.commentList(comment.getBoardid()));
      }else {
         result.put("status", false);
         result.put("message", "댓글이 등록되지 않았습니다.");   
      }
      
      System.out.println("status : "+status);
      
      return result;
      
   } //register
   
   
   //2. 댓글 목록보기
//   @RequestMapping("/comment/list.do")
//   public Map<String, Object> list(CommentDTO comment) throws Exception {
//      System.out.println("comment.controller.list() invoked.");
//      
//      Map<String, Object> result = new HashMap<>();
//      boolean status = service.commentList(comment) != null;
//      
//      if(status) {      
//         result.put("status", true);
//         result.put("message", "리스트 출력됨");
//      }else {
//         result.put("status", false);
//         result.put("message", "리스트 출력안됨");   
//      }
//      
//      System.out.println("status : "+status);
//      
//      return result;
//   
//   } //list
   
   
   //3. 댓글 수정하기
   @ResponseBody
   @RequestMapping("/comment/modify.do")
   public Map<String, Object> modify(@RequestBody CommentDTO comment) throws Exception {
      System.out.println("comment.controller.modify() invoked.");
      
      Map<String, Object> result = new HashMap<>();
      boolean status = service.commentUpdate(comment);
      
      if(status) {      
         result.put("status", true);
         result.put("message", "댓글이 수정되었습니다.");
      }else {
         result.put("status", false);
         result.put("message", "댓글이 수정되지 않았습니다."); 
         result.put("comment", service.commentList(comment.getBoardid()));
      }
      
      System.out.println("status : "+status);
      
      return result;
   
   } //modify
   
   
   //4. 댓글 삭제하기
   @ResponseBody
   @RequestMapping("/comment/remove.do")
   public Map<String, Object> remove(@RequestBody CommentDTO comment) throws Exception {
      System.out.println("comment.controller.remove() invoked.");
      
      Map<String, Object> result = new HashMap<>();
      boolean status = service.commentDelete(comment);
      
      if(status) {      
         result.put("status", true);
         result.put("message", "댓글이 삭제되었습니다.");
         result.put("comment", service.commentList(comment.getBoardid()));
      }else {
         result.put("status", false);
         result.put("message", "댓글이 삭제되지 않았습니다.");   
      }
      
      System.out.println("status : "+status);
      
      return result;
   
   } //remove
   
} // end class