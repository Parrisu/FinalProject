package com.skilldistillery.stack.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.NodeMember;
import com.skilldistillery.stack.entities.NodeMemberId;

public interface NodeMemberRepository extends JpaRepository<NodeMember, NodeMemberId>{
//	@Query("SELECT nm FROM NodeMember nm WHERE nm.user.id = :userId AND nm.node.id = :nodeId")
//	public NodeMember findNodeMemberByUserIdAndNodeId(int userId, int nodeId);
}
