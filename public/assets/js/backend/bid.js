define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'bid/index',
                    add_url: 'bid/add',
                    edit_url: 'bid/edit',
                    del_url: 'bid/del',
                    multi_url: 'bid/multi',
                    table: 'bid',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'user', title: "关联会员"},
                        {field: 'type', title: __('Type'), formatter(obj){
                            return obj == 'labour'?'劳务':'货物';
                        },searchList: {"labour": '劳务', "cargo": '货物'}},
                        {field: 'name', title: __('Name')},
                        {field: 'budget', title: __('Budget'), operate:'BETWEEN'},
                        {field: 'pay_way', title: __('Pay_way')},
                        {field: 'start_time', title: __('Start_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.date},
                        {field: 'end_time', title: __('End_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.date},
                        {field: 'bid_start_time', title: __('Bid_start_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.date},
                        {field: 'bid_end_time', title: __('Bid_end_time'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.date},
                        {field: 'phone', title: __('Phone')},
                        {field: 'can_contact_start_time', title: __('Can_contact_start_time')},
                        {field: 'can_contact_end_time', title: __('Can_contact_end_time')},
                        {field: 'province', title: __('Province')},
                        {field: 'city', title: __('City')},
                        // {field: 'status', title: __('Status'), formatter: function(obj){
                        //         return obj ? '通过' : '未通过';
                        // }},
                        {field: 'status', title: '审核通过',formatter:Table.api.formatter.toggle,searchList: {"0": '未审核', "1": '已审核'}},
                        {field: 'see_pay', title: __('See_pay'), operate:'BETWEEN'},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate},
                        // {
                        //     field: 'operate',
                        //     title: __('Operate'),
                        //     table: table,
                        //     events: Table.api.events.operate,
                        //     buttons: [{
                        //         name: 'enable',
                        //         title: '通过',
                        //         classname: 'btn btn-xs btn-default btn-ajax confirm',
                        //         refresh: true,
                        //         icon: 'fa fa-check',
                        //         url: 'bid/check'
                        //     },
                        //         {
                        //             name: 'disable',
                        //             title: '不通过',
                        //             classname: 'btn btn-xs btn-danger btn-ajax confirm',
                        //             refresh: true,
                        //             icon: 'fa fa-close',
                        //             url: 'bid/uncheck'
                        //         }],
                        //     formatter: Table.api.formatter.operate
                        // }
                    ]
                ]
            });

            

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});